# Aster Financial Services Transaction Management — database design

My case study records customer, bank_account, financial_transaction.

## Users

- Retail banking customers
- Tellers and digital banking services
- Operations analysts

## Main operations

- Open accounts for customers
- Post and review account transactions
- Summarise transaction activity by customer

## Entities

| Entity | Information stored |
| --- | --- |
| customer | A synthetic banking customer who may own accounts. |
| bank_account | An account owned by one customer, with its balance and lifecycle details. |
| financial_transaction | A synthetic posted or reversed monetary transaction belonging to one bank account. |

## customer

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| customer_id | BIGINT | PK | Yes |
| full_name | TEXT |  | Yes |
| email | TEXT | Unique | Yes |
| joined_on | DATE |  | Yes |
- Unique key: (email).

## bank_account

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| account_id | BIGINT | PK | Yes |
| customer_id | BIGINT | FK | Yes |
| account_number | TEXT | Unique | Yes |
| currency_code | TEXT |  | Yes |
| current_balance | NUMERIC(18,2) |  | Yes |
| opened_on | DATE |  | Yes |
| status | TEXT |  | Yes |
- customer_id → customer.customer_id
- Unique key: (account_number).

## financial_transaction

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| transaction_id | BIGINT | PK | Yes |
| account_id | BIGINT | FK | Yes |
| reference_code | TEXT | Unique | Yes |
| amount | NUMERIC(18,2) |  | Yes |
| booked_at | TIMESTAMPTZ |  | Yes |
| direction | TEXT |  | Yes |
| status | TEXT |  | Yes |
- account_id → bank_account.account_id
- Unique key: (reference_code).

## Relationships and business rules

- Each customer email identifies at most one customer.
- Every bank account references an existing customer through customer_id.
- An account current_balance must be at least zero.
- Every financial transaction references an existing bank account through account_id.
- Every financial transaction amount must be greater than zero.

## Assumptions

- All records and identifiers are synthetic; every entity has a globally unique, single-column primary key.
- Each bank account belongs to exactly one customer, and each financial transaction belongs to exactly one bank account.
- Transaction amounts are positive; account balances must remain nonnegative.
- The worked normalisation example follows financial_transaction to bank_account to customer, representing each ancestor role once.

