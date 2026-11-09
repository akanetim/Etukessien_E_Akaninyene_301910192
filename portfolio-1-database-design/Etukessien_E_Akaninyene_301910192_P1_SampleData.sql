-- Fictional sample records for Aster Financial Services Transaction Management.
BEGIN;
SET LOCAL standard_conforming_strings = on;
INSERT INTO portfolio."customer" ("customer_id", "full_name", "email", "joined_on") VALUES (101, 'Avery Morgan', 'avery.morgan@example.test', '2024-01-15');
INSERT INTO portfolio."customer" ("customer_id", "full_name", "email", "joined_on") VALUES (102, 'Jordan Lee', 'jordan.lee@example.test', '2024-03-22');
INSERT INTO portfolio."bank_account" ("account_id", "customer_id", "account_number", "currency_code", "current_balance", "opened_on", "status") VALUES (201, 101, 'ACCT-TEST-001', 'USD', 1250.5, '2024-02-01', 'active');
INSERT INTO portfolio."bank_account" ("account_id", "customer_id", "account_number", "currency_code", "current_balance", "opened_on", "status") VALUES (202, 102, 'ACCT-TEST-002', 'EUR', 840, '2024-04-10', 'active');
INSERT INTO portfolio."financial_transaction" ("transaction_id", "account_id", "reference_code", "amount", "booked_at", "direction", "status") VALUES (301, 201, 'REF-TEST-001', 75.25, '2024-05-01T10:30:00Z', 'credit', 'posted');
INSERT INTO portfolio."financial_transaction" ("transaction_id", "account_id", "reference_code", "amount", "booked_at", "direction", "status") VALUES (302, 202, 'REF-TEST-002', 30, '2024-05-02T14:15:00+00:00', 'debit', 'posted');
COMMIT;
