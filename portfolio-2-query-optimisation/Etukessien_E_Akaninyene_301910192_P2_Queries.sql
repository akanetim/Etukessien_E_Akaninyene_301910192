-- Show related financial_transaction, bank_account, customer records (up to 20).
SELECT t0."transaction_id" AS "financial_transaction_transaction_id",
       t0."reference_code" AS "financial_transaction_reference_code",
       t1."account_id" AS "bank_account_account_id",
       t1."account_number" AS "bank_account_account_number",
       t2."customer_id" AS "customer_customer_id",
       t2."full_name" AS "customer_full_name"
FROM portfolio."financial_transaction" t0
JOIN portfolio."bank_account" t1 ON t0."account_id" = t1."account_id"
JOIN portfolio."customer" t2 ON t1."customer_id" = t2."customer_id"
ORDER BY t0."transaction_id", t1."account_id", t2."customer_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT t0."transaction_id" AS "financial_transaction_transaction_id",
       t0."reference_code" AS "financial_transaction_reference_code",
       t1."account_id" AS "bank_account_account_id",
       t1."account_number" AS "bank_account_account_number",
       t2."customer_id" AS "customer_customer_id",
       t2."full_name" AS "customer_full_name"
FROM portfolio."financial_transaction" t0
JOIN portfolio."bank_account" t1 ON t0."account_id" = t1."account_id"
JOIN portfolio."customer" t2 ON t1."customer_id" = t2."customer_id"
ORDER BY t0."transaction_id", t1."account_id", t2."customer_id"
LIMIT 20;

-- Find financial_transaction records where booked_at matches "2024-05-01T10:30:00Z" (up to 20).
SELECT * FROM portfolio."financial_transaction"
WHERE "booked_at" IS NOT DISTINCT FROM '2024-05-01T10:30:00Z'
ORDER BY "transaction_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT * FROM portfolio."financial_transaction"
WHERE "booked_at" IS NOT DISTINCT FROM '2024-05-01T10:30:00Z'
ORDER BY "transaction_id"
LIMIT 20;

-- Count financial_transaction records for each account_id (up to 20 groups).
SELECT "account_id", count(*) AS record_count
FROM portfolio."financial_transaction"
GROUP BY "account_id"
ORDER BY record_count DESC, "account_id" NULLS LAST
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT "account_id", count(*) AS record_count
FROM portfolio."financial_transaction"
GROUP BY "account_id"
ORDER BY record_count DESC, "account_id" NULLS LAST
LIMIT 20;
