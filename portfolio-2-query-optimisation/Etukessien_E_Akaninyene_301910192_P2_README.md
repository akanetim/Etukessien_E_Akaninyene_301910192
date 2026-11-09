# Aster Financial Services Transaction Management — SQL queries

## 1. Show related financial_transaction, bank_account, customer records (up to 20).

```sql
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
```

| financial_transaction_transaction_id | financial_transaction_reference_code | bank_account_account_id | bank_account_account_number | customer_customer_id | customer_full_name |
| --- | --- | --- | --- | --- | --- |
| 301 | REF-TEST-001 | 201 | ACCT-TEST-001 | 101 | Avery Morgan |
| 302 | REF-TEST-002 | 202 | ACCT-TEST-002 | 102 | Jordan Lee |

## 2. Find financial_transaction records where booked_at matches "2024-05-01T10:30:00Z" (up to 20).

```sql
SELECT * FROM portfolio."financial_transaction"
WHERE "booked_at" IS NOT DISTINCT FROM '2024-05-01T10:30:00Z'
ORDER BY "transaction_id"
LIMIT 20;
```

| transaction_id | account_id | reference_code | amount | booked_at | direction | status |
| --- | --- | --- | --- | --- | --- | --- |
| 301 | 201 | REF-TEST-001 | 75.25 | 2024-05-01T10:30:00+00:00 | credit | posted |

## 3. Count financial_transaction records for each account_id (up to 20 groups).

```sql
SELECT "account_id", count(*) AS record_count
FROM portfolio."financial_transaction"
GROUP BY "account_id"
ORDER BY record_count DESC, "account_id" NULLS LAST
LIMIT 20;
```

| account_id | record_count |
| --- | --- |
| 201 | 1 |
| 202 | 1 |


## Index comparison

| Phase | Median (ms) | Three runs (ms) | Plan nodes | Buffer hits |
| --- | --- | --- | --- | --- |
| Before index | 2.43 | 2.43, 2.573, 2.427 | Sort → Seq Scan | 274 |
| After index | 0.28 | 0.281, 0.28, 0.278 | Sort → Bitmap Heap Scan → Bitmap Index Scan | 55 |

The median execution time changed from 2.43 ms to 0.28 ms. The measured plan used p2_filter_idx. The results matched in both phases. An index adds storage and write-maintenance costs; timings depend on the selected lookup and environment.

## Execution plans

### Before index, run 1

```text
Sort (actual time=2.399..2.401 rows=50 loops=1)
  Seq Scan on financial_transaction (actual time=0.014..2.359 rows=50 loops=1)
Planning Time: 0.34 ms
Execution Time: 2.43 ms
```

### Before index, run 2

```text
Sort (actual time=2.542..2.544 rows=50 loops=1)
  Seq Scan on financial_transaction (actual time=0.014..2.502 rows=50 loops=1)
Planning Time: 0.327 ms
Execution Time: 2.573 ms
```

### Before index, run 3

```text
Sort (actual time=2.396..2.398 rows=50 loops=1)
  Seq Scan on financial_transaction (actual time=0.015..2.357 rows=50 loops=1)
Planning Time: 0.343 ms
Execution Time: 2.427 ms
```

### After index, run 1

```text
Sort (actual time=0.225..0.227 rows=50 loops=1)
  Bitmap Heap Scan on financial_transaction (actual time=0.029..0.185 rows=50 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.015..0.016 rows=50 loops=1)
Planning Time: 0.557 ms
Execution Time: 0.281 ms
```

### After index, run 2

```text
Sort (actual time=0.224..0.227 rows=50 loops=1)
  Bitmap Heap Scan on financial_transaction (actual time=0.031..0.187 rows=50 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.015..0.016 rows=50 loops=1)
Planning Time: 0.561 ms
Execution Time: 0.28 ms
```

### After index, run 3

```text
Sort (actual time=0.223..0.225 rows=50 loops=1)
  Bitmap Heap Scan on financial_transaction (actual time=0.03..0.183 rows=50 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.015..0.016 rows=50 loops=1)
Planning Time: 0.554 ms
Execution Time: 0.278 ms
```

## Reproduce

Use a fresh database with the Portfolio 1 schema and sample data. Run Etukessien_E_Akaninyene_301910192_P2_Queries.sql, then Etukessien_E_Akaninyene_301910192_P2_Optimisation.sql. The optimisation script creates a separate performance table and runs EXPLAIN (ANALYZE, BUFFERS).

[Query screenshot](screenshots/Etukessien_E_Akaninyene_301910192_P2_QueryResults.png) · [Index comparison](screenshots/Etukessien_E_Akaninyene_301910192_P2_IndexComparison.png)

## References

- [PostgreSQL — EXPLAIN](https://www.postgresql.org/docs/17/using-explain.html)

