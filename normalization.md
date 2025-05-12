# Database Normalization to 3NF for Airbnb-Clone Project

This document outlines the process of normalizing the Airbnb-clone database schema to achieve **Third Normal Form (3NF)**. The objectives are to eliminate redundancies, ensure data integrity, and remove transitive dependencies.

## Initial Schema Review

The original schema includes six tables: **User**, **Property**, **Booking**, **Payment**, **Review**, and **Message**. Each table was evaluated for compliance with 1NF, 2NF, and 3NF.

### 1NF Check

**Criteria**:

- Atomic attributes.
- Unique primary keys.
- No repeating groups or multi-valued attributes.

**Findings**:

- All attributes (e.g., `first_name`, `location`) are atomic.
- Each table has a UUID primary key (e.g., `user_id`, `property_id`).
- No repeating groups or multi-valued attributes (e.g., `phone_number` is a single VARCHAR).

**Conclusion**: All tables are in **1NF**.

### 2NF Check

**Criteria**:

- Must be in 1NF.
- No partial dependencies (non-key attributes must depend on the entire primary key).

**Findings**:

- All tables have single-column primary keys (UUIDs), so partial dependencies are not applicable.
- Non-key attributes (e.g., `name`, `rating`) depend fully on their primary keys.

**Conclusion**: All tables are in **2NF**.

### 3NF Check

**Criteria**:

- Must be in 2NF.
- No transitive dependencies (non-key attributes must not depend on other non-key attributes).

**Issues Identified**:

1. **Property.location** (VARCHAR) may store composite data (e.g., "Paris, France, 75001"), leading to redundancy and transitive dependencies (e.g., `postal_code` → `city` → `country`).
2. **Booking.total_price** is derived from `start_date`, `end_date`, and `Property.pricepernight`, violating 3NF due to dependency on non-key attributes.
3. **Payment.amount** duplicates the booking’s total price (or its computed value), creating redundancy and a transitive dependency.

## Normalization Steps

### Step 1: Normalize Property.location

**Issue**:

- `location` stores composite data (e.g., city, country, postal code), causing redundancy if multiple properties share the same city/country. This introduces transitive dependencies (e.g., `postal_code` → `city`).

**Solution**:

- Created a new **Location** table with attributes:
  - `location_id` (PK, UUID)
  - `city` (VARCHAR, NOT NULL)
  - `country` (VARCHAR, NOT NULL)
  - `postal_code` (VARCHAR, NULL)
  - `created_at` (TIMESTAMP)
- Added a unique constraint on `(city, country, postal_code)` to prevent duplicate locations.
- Replaced `location` (VARCHAR) in **Property** with `location_id` (FK → Location.location_id).

**Reason**:

- This eliminates redundancy by storing each unique location once and removes transitive dependencies (e.g., `postal_code` no longer determines `city` within **Property**). It also supports efficient location-based queries.

### Step 2: Remove Booking.total_price

**Issue**:

- `total_price` is derived (`pricepernight * DATEDIFF(end_date, start_date)`), violating 3NF because it depends on non-key attributes (`start_date`, `end_date`, `Property.pricepernight`).

**Solution**:

- Removed `total_price` from **Booking**.
- Compute `total_price` dynamically in queries:
  ```sql
  SELECT
      b.booking_id,
      (DATEDIFF(b.end_date, b.start_date) * p.pricepernight) AS total_price
  FROM Booking b
  JOIN Property p ON b.property_id = p.property_id;
  ```

**Reason**:

- Storing derived data risks inconsistency (e.g., if `pricepernight` changes, `total_price` must be updated). Computing it dynamically ensures 3NF compliance and maintains data integrity.

### Step 3: Remove Payment.amount

**Issue**:

- `amount` duplicates the booking’s total price (or its computed value), introducing redundancy and a transitive dependency.

**Solution**:

- Removed `amount` from **Payment**.
- Derive the payment amount via a join:
  ```sql
  SELECT
      p.payment_id,
      (DATEDIFF(b.end_date, b.start_date) * pr.pricepernight) AS amount
  FROM Payment p
  JOIN Booking b ON p.booking_id = b.booking_id
  JOIN Property pr ON b.property_id = pr.property_id;
  ```

**Reason**:

- Eliminating `amount` reduces redundancy and ensures **Payment** attributes depend only on `payment_id` and `booking_id`. For auditing purposes, `amount` could be reintroduced with justification, but it’s removed for strict 3NF compliance.

### Step 4: Verify Other Tables

- **User**:
  - Attributes (`first_name`, `last_name`, etc.) depend directly on `user_id`. No transitive dependencies.
- **Review**:
  - Attributes (`rating`, `comment`) depend on `review_id`. No transitive dependencies.
- **Message**:
  - Attributes (`message_body`, `sent_at`) depend on `message_id`. No transitive dependencies.
- **Constraints**:
  - Added a unique constraint on `Location(city, country, postal_code)` to prevent duplicates.
  - Ensured foreign key constraints (e.g., `ON DELETE RESTRICT`) maintain referential integrity.

## Benefits of Normalization

- **Reduced Redundancy**: The **Location** table ensures city/country data is stored once, minimizing duplication.
- **Data Integrity**: Removing derived attributes (`total_price`, `amount`) prevents inconsistencies.
- **Scalability**: The schema supports future extensions (e.g., adding more location attributes).
- **Query Efficiency**: Foreign keys and unique constraints optimize joins and lookups.

## Considerations

- **Performance**: Computing `total_price` dynamically may increase query complexity. Consider materialized views or generated columns (e.g., in PostgreSQL) for optimization.
- **Auditing**: If `Payment.amount` is needed for historical records (e.g., to lock in prices), it could be reintroduced with clear justification, but this was avoided for strict 3NF compliance.
- **AI Integration**: The normalized schema is compatible with xAI Grok API use cases, such as generating `Property.description`, moderating `Review.comment`, or recommending properties based on `Location.city`.

## Conclusion

The database is now in **3NF**, with no transitive dependencies or redundancies. The changes ensure a robust, scalable design for the Airbnb-clone project. For further refinements, query optimizations, or xAI Grok API integration (e.g., generating property descriptions), please provide additional requirements or specify the tech stack.
