import argparse
import os
import re
import sys
from pathlib import Path

import psycopg2

SQL_FILE = Path(__file__).parent / "insert.sql"


TABLES_CHILD_TO_PARENT = [
    "card",
    "hist_transactional",
    "account",
    "product",
    "branch",
    "customer",
]

SECTION_RE = re.compile(r"--\s*\d+\.\s*([A-Z_]+)\s+TABLE", re.IGNORECASE)


def get_connection():
    return psycopg2.connect(
        host=os.environ.get("PGHOST", "localhost"),
        port=os.environ.get("PGPORT", "5432"),
        dbname=os.environ.get("PGDATABASE", "postgres"),
        user=os.environ.get("PGUSER", "postgres"),
        password=os.environ.get("PGPASSWORD", "postgres"),
    )


def load_sql_script() -> str:
    if not SQL_FILE.exists():
        sys.exit(f"SQL file not found: {SQL_FILE}")
    return SQL_FILE.read_text(encoding="utf-8")


def split_into_table_sections(sql_text: str):
    """Splits insert.sql into (table_name, sql_chunk) pairs, one per
    numbered section header, in the order they appear in the file."""
    matches = list(SECTION_RE.finditer(sql_text))
    if not matches:
        sys.exit(f"No '-- N. <TABLE> TABLE' section headers found in {SQL_FILE.name}")

    sections = []
    for i, m in enumerate(matches):
        table_name = m.group(1).lower()
        start = m.start()
        end = matches[i + 1].start() if i + 1 < len(matches) else len(sql_text)
        sections.append((table_name, sql_text[start:end]))
    return sections


def table_exists(cur, table_name: str) -> bool:
    cur.execute(
        """
        SELECT EXISTS (
            SELECT 1 FROM information_schema.tables
            WHERE table_schema = 'public' AND table_name = %s
        )
        """,
        (table_name,),
    )
    return cur.fetchone()[0]


def drop_existing_tables(cur):
    for table in TABLES_CHILD_TO_PARENT:
        print(f"  DROP TABLE IF EXISTS {table} CASCADE;")
        cur.execute(f"DROP TABLE IF EXISTS {table} CASCADE;")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--drop",
        action="store_true",
        help="Drop customer/branch/product/account/card/hist_transactional first (safe re-run).",
    )
    args = parser.parse_args()

    sections = split_into_table_sections(load_sql_script())

    conn = get_connection()
    try:
        conn.autocommit = False

        with conn.cursor() as cur:
            cur.execute("SET search_path TO public;")
        conn.commit()

        if args.drop:
            print("Dropping existing tables (if any)...")
            with conn.cursor() as cur:
                drop_existing_tables(cur)
            conn.commit()

        print(f"Processing {SQL_FILE.name} ({len(sections)} tables) ...")
        for table_name, chunk in sections:
            with conn.cursor() as cur:
                if table_exists(cur, table_name):
                    print(f"  {table_name}: already exists - skipping.")
                    continue

            try:
                with conn.cursor() as cur:
                    cur.execute(chunk)
                conn.commit()
                print(f"  {table_name}: created and loaded.")
            except Exception as e:
                conn.rollback()
                print(f"  {table_name}: FAILED - {e}")
                raise

        print("\nRow counts:")
        with conn.cursor() as cur:
            for table in reversed(TABLES_CHILD_TO_PARENT):
                if table_exists(cur, table):
                    cur.execute(f"SELECT COUNT(*) FROM public.{table};")
                    (count,) = cur.fetchone()
                    print(f"  public.{table}: {count} rows")
                else:
                    print(f"  public.{table}: (does not exist)")

        print("\nDone.")
    finally:
        conn.close()


if __name__ == "__main__":
    main()
