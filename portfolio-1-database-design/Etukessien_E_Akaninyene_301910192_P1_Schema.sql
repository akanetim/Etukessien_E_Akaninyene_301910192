-- Aster Financial Services Transaction Management: tables, keys and business constraints.
-- Run once in a fresh PostgreSQL database.
BEGIN;
SET LOCAL standard_conforming_strings = on;
CREATE SCHEMA portfolio;
CREATE TABLE portfolio."customer" (
  "customer_id" bigint NOT NULL,
  "full_name" text NOT NULL,
  "email" text NOT NULL,
  "joined_on" date NOT NULL,
  CONSTRAINT "pk_customer" PRIMARY KEY ("customer_id"),
  CONSTRAINT "uq_customer_0" UNIQUE ("email")
);
CREATE TABLE portfolio."bank_account" (
  "account_id" bigint NOT NULL,
  "customer_id" bigint NOT NULL,
  "account_number" text NOT NULL,
  "currency_code" text NOT NULL,
  "current_balance" numeric(18,2) NOT NULL,
  "opened_on" date NOT NULL,
  "status" text NOT NULL,
  CONSTRAINT "pk_bank_account" PRIMARY KEY ("account_id"),
  CONSTRAINT "uq_bank_account_0" UNIQUE ("account_number")
);
CREATE TABLE portfolio."financial_transaction" (
  "transaction_id" bigint NOT NULL,
  "account_id" bigint NOT NULL,
  "reference_code" text NOT NULL,
  "amount" numeric(18,2) NOT NULL,
  "booked_at" timestamptz NOT NULL,
  "direction" text NOT NULL,
  "status" text NOT NULL,
  CONSTRAINT "pk_financial_transaction" PRIMARY KEY ("transaction_id"),
  CONSTRAINT "uq_financial_transaction_0" UNIQUE ("reference_code")
);
ALTER TABLE portfolio."bank_account" ADD CONSTRAINT "fk_bank_account_0" FOREIGN KEY ("customer_id") REFERENCES portfolio."customer" ("customer_id");
ALTER TABLE portfolio."financial_transaction" ADD CONSTRAINT "fk_financial_transaction_0" FOREIGN KEY ("account_id") REFERENCES portfolio."bank_account" ("account_id");
ALTER TABLE portfolio."bank_account" ADD CONSTRAINT "account_balance_nonnegative" CHECK ("current_balance" >= 0);
ALTER TABLE portfolio."financial_transaction" ADD CONSTRAINT "transaction_amount_positive" CHECK ("amount" > 0);
COMMIT;
