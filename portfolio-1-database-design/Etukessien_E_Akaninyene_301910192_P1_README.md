# Portfolio 1 — Database Design and Modelling

I organised the data into customer, bank_account, financial_transaction. The design document explains the fields, keys, relationships and business rules. The normalisation document shows the sample tables at 1NF, 2NF and 3NF.

## Database checks

| Table | Rows |
| --- | --- |
| customer | 2 |
| bank_account | 2 |
| financial_transaction | 2 |

The 11 invalid inserts were rejected at their expected constraints, and the valid sample rows remained unchanged.

## Files

- [Design](Etukessien_E_Akaninyene_301910192_P1_Design.md)
- [ER diagram](Etukessien_E_Akaninyene_301910192_P1_ERDiagram.md)
- [Normalisation](Etukessien_E_Akaninyene_301910192_P1_Normalisation.md)
- [Schema](Etukessien_E_Akaninyene_301910192_P1_Schema.sql)
- [Sample data](Etukessien_E_Akaninyene_301910192_P1_SampleData.sql)
- [Constraint tests](Etukessien_E_Akaninyene_301910192_P1_ConstraintTests.sql)
- [Table and constraint evidence](screenshots/Etukessien_E_Akaninyene_301910192_P1_DatabaseResults.png)

## Run the SQL

Create a fresh PostgreSQL database. Run the schema first, then the sample data. Run the deliberately invalid statements in ConstraintTests.sql individually outside a transaction; each is expected to produce an error.

## References

- [PostgreSQL — constraints](https://www.postgresql.org/docs/17/ddl-constraints.html)

