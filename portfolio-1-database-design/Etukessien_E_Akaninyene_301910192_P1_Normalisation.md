# Aster Financial Services Transaction Management — normalisation

The example uses the saved sample records. The full set of fields is in the design and schema.

## Starting grouped records

| account_id | financial_transaction records (list) |
| --- | --- |
| 201 | [301] |
| 202 | [302] |


The record IDs are grouped in a list. In 1NF, each record has its own row and each cell holds one value.

## 1NF: one value per cell

| financial_transaction.transaction_id | financial_transaction.account_id | financial_transaction.reference_code | bank_account.account_id | bank_account.customer_id | bank_account.account_number | customer.customer_id | customer.full_name |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 301 | 201 | REF-TEST-001 | 201 | 101 | ACCT-TEST-001 | 101 | Avery Morgan |
| 302 | 202 | REF-TEST-002 | 202 | 102 | ACCT-TEST-002 | 102 | Jordan Lee |

Key: transaction_id.

## 2NF: depend on the whole key

The declared candidate keys do not introduce a partial dependency here, so the 1NF rows stay unchanged at this step.

## financial_transaction_example

| financial_transaction.transaction_id | financial_transaction.account_id | financial_transaction.reference_code | bank_account.account_id | bank_account.customer_id | bank_account.account_number | customer.customer_id | customer.full_name |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 301 | 201 | REF-TEST-001 | 201 | 101 | ACCT-TEST-001 | 101 | Avery Morgan |
| 302 | 202 | REF-TEST-002 | 202 | 102 | ACCT-TEST-002 | 102 | Jordan Lee |

## 3NF: store each entity’s details once

The entity keys determine their own descriptions. Related records keep foreign keys rather than repeating those descriptions.

## customer

| customer_id | full_name | email | joined_on |
| --- | --- | --- | --- |
| 101 | Avery Morgan | avery.morgan@example.test | 2024-01-15 |
| 102 | Jordan Lee | jordan.lee@example.test | 2024-03-22 |

## bank_account

| account_id | customer_id | account_number | currency_code | current_balance | opened_on | status |
| --- | --- | --- | --- | --- | --- | --- |
| 201 | 101 | ACCT-TEST-001 | USD | 1250.5 | 2024-02-01 | active |
| 202 | 102 | ACCT-TEST-002 | EUR | 840 | 2024-04-10 | active |

## financial_transaction

| transaction_id | account_id | reference_code | amount | booked_at | direction | status |
| --- | --- | --- | --- | --- | --- | --- |
| 301 | 201 | REF-TEST-001 | 75.25 | 2024-05-01T10:30:00+00:00 | credit | posted |
| 302 | 202 | REF-TEST-002 | 30 | 2024-05-02T14:15:00+00:00 | debit | posted |

## Dependencies

- customer: (customer_id) → full_name, email, joined_on
- bank_account: (account_id) → customer_id, account_number, currency_code, current_balance, opened_on, status
- financial_transaction: (transaction_id) → account_id, reference_code, amount, booked_at, direction, status

Joining the decomposed sample tables reproduces the original 2 example rows. The design assumes the declared keys describe the relevant business dependencies.
