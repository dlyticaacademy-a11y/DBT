# dbt (Data Build Tool)

## 📌 Overview

**dbt (Data Build Tool)** is an open-source tool used to transform data inside a data warehouse or database using SQL.

dbt focuses mainly on the **T (Transform)** part of the ELT process.

With dbt, you can:

* Transform raw data using SQL
* Create tables and views
* Build dependencies between SQL models
* Test data quality
* Document data models
* Track lineage between models
* Use reusable macros
* Schedule dbt jobs using tools such as Airflow

### ELT Flow

```text
Source Data
    ↓
Raw / Bronze Layer
    ↓
dbt Staging Models
    ↓
dbt Intermediate Models
    ↓
dbt Mart / Gold Models
    ↓
Analytics / BI
```

---

# 🚀 Installation

## 1. Check Python

dbt requires Python.

Check your Python version:

```bash
python --version
```

or:

```bash
python3 --version
```

---

## 2. Create a Virtual Environment

It is recommended to use a Python virtual environment.

### Windows

```powershell
python -m venv venv
```

Activate it:

```powershell
.\venv\Scripts\activate
```

### Linux / macOS

```bash
python3 -m venv venv
source venv/bin/activate
```

---

# 📦 Install dbt

dbt consists of the **dbt Core** engine and a database-specific adapter.

For example, if you are using PostgreSQL:

```bash
pip install dbt-postgres
```

For Snowflake:

```bash
pip install dbt-snowflake
```

For Databricks:

```bash
pip install dbt-databricks
```

For BigQuery:

```bash
pip install dbt-bigquery
```

For Trino:

```bash
pip install dbt-trino
```

---

# 🔍 Verify Installation

Check the installed dbt version:

```bash
dbt --version
```

Example:

```text
Core:
  - installed: 1.x.x

Plugins:
  - postgres: 1.x.x
```

---

# 🏗️ Create a dbt Project

Create a new project:

```bash
dbt init my_dbt_project
```

Move into the project:

```bash
cd my_dbt_project
```

A typical dbt project looks like:

```text
my_dbt_project/
│
├── dbt_project.yml
```
