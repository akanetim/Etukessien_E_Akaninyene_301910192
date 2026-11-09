# Aster Financial Services Transaction Management — ER diagram

```mermaid
erDiagram
    direction LR
    customer {
        bigint customer_id PK
        text full_name
        text email UK
        date joined_on
    }
    bank_account {
        bigint account_id PK
        bigint customer_id FK
        text account_number UK
        text currency_code
        numeric current_balance
        date opened_on
        text status
    }
    financial_transaction {
        bigint transaction_id PK
        bigint account_id FK
        text reference_code UK
        numeric amount
        timestamptz booked_at
        text direction
        text status
    }
    customer ||--o{ bank_account : "customer_id"
    bank_account ||--o{ financial_transaction : "account_id"
```

PK identifies a record; FK links to another table; UK marks a single-field unique value. The relationship ends show exactly one, zero or one, or zero or many records. Composite unique keys and conditional rules are listed in the schema and design.

[Diagram image](../images/Etukessien_E_Akaninyene_301910192_ERDiagram.png)
