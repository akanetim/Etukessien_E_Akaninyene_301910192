-- Run these deliberately invalid statements one at a time, outside a transaction.
-- Each should fail at the named constraint; the sample rows should remain unchanged.

-- 1. test customer pk. Expected: pk_customer, SQLSTATE 23505.
INSERT INTO portfolio."customer" ("customer_id", "full_name", "email", "joined_on")
VALUES (101, 'Case Customer', 'case.customer@example.test', '2024-06-01');

-- 2. test customer unique. Expected: uq_customer_0, SQLSTATE 23505.
INSERT INTO portfolio."customer" ("customer_id", "full_name", "email", "joined_on")
VALUES (401, 'Unique Customer', 'avery.morgan@example.test', '2024-06-02');

-- 3. test customer not null. Expected: full_name, SQLSTATE 23502.
INSERT INTO portfolio."customer" ("customer_id", "full_name", "email", "joined_on")
VALUES (402, NULL, 'null.name@example.test', '2024-06-03');

-- 4. test account pk. Expected: pk_bank_account, SQLSTATE 23505.
INSERT INTO portfolio."bank_account" ("account_id", "customer_id", "account_number", "currency_code", "current_balance", "opened_on", "status")
VALUES (201, 101, 'ACCT-TEST-PK', 'USD', 25, '2024-06-04', 'active');

-- 5. test account unique. Expected: uq_bank_account_0, SQLSTATE 23505.
INSERT INTO portfolio."bank_account" ("account_id", "customer_id", "account_number", "currency_code", "current_balance", "opened_on", "status")
VALUES (403, 101, 'ACCT-TEST-001', 'USD', 25, '2024-06-05', 'active');

-- 6. test account fk. Expected: fk_bank_account_0, SQLSTATE 23503.
INSERT INTO portfolio."bank_account" ("account_id", "customer_id", "account_number", "currency_code", "current_balance", "opened_on", "status")
VALUES (404, 99999, 'ACCT-TEST-FK', 'USD', 25, '2024-06-06', 'active');

-- 7. test account check. Expected: account_balance_nonnegative, SQLSTATE 23514.
INSERT INTO portfolio."bank_account" ("account_id", "customer_id", "account_number", "currency_code", "current_balance", "opened_on", "status")
VALUES (405, 101, 'ACCT-TEST-CHECK', 'USD', -1, '2024-06-07', 'active');

-- 8. test transaction pk. Expected: pk_financial_transaction, SQLSTATE 23505.
INSERT INTO portfolio."financial_transaction" ("transaction_id", "account_id", "reference_code", "amount", "booked_at", "direction", "status")
VALUES (301, 201, 'REF-TEST-PK', 10, '2024-06-08T09:00:00Z', 'credit', 'posted');

-- 9. test transaction unique. Expected: uq_financial_transaction_0, SQLSTATE 23505.
INSERT INTO portfolio."financial_transaction" ("transaction_id", "account_id", "reference_code", "amount", "booked_at", "direction", "status")
VALUES (406, 201, 'REF-TEST-001', 10, '2024-06-09T09:00:00Z', 'credit', 'posted');

-- 10. test transaction fk. Expected: fk_financial_transaction_0, SQLSTATE 23503.
INSERT INTO portfolio."financial_transaction" ("transaction_id", "account_id", "reference_code", "amount", "booked_at", "direction", "status")
VALUES (407, 99998, 'REF-TEST-FK', 10, '2024-06-10T09:00:00Z', 'credit', 'posted');

-- 11. test transaction check. Expected: transaction_amount_positive, SQLSTATE 23514.
INSERT INTO portfolio."financial_transaction" ("transaction_id", "account_id", "reference_code", "amount", "booked_at", "direction", "status")
VALUES (408, 201, 'REF-TEST-CHECK', 0, '2024-06-11T09:00:00Z', 'credit', 'posted');
