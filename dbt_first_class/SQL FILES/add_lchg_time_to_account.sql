-- Migration for the account table that already exists in public (created
-- before lchg_time and the negative-loan-balance rule existed). Safe to
-- run more than once.

-- Step 1: add lchg_time, defaulting existing rows to now.
ALTER TABLE account
    ADD COLUMN IF NOT EXISTS lchg_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- Step 2: relax the balance check so loan (LD) accounts can be negative,
-- while every other scheme type must stay non-negative.
ALTER TABLE account
    DROP CONSTRAINT IF EXISTS chk_balance;

ALTER TABLE account
    ADD CONSTRAINT chk_balance CHECK (schm_type = 'LD' OR account_balance >= 0);
