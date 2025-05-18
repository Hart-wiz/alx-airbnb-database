# step 1: Identify High-Usage Columns

## User Table

user_id (used in joins and filters)


## Booking Table

booking_id (primary key)

user_id (foreign key for joins)

property_id (foreign key for joins)

date (likely used for filtering/sorting)


## Property Table

property_id (used in joins)

name (possibly used in searches or sorting)


# Step 2: Write CREATE INDEX Commands
query present in database_index.sql

# Step 3: Measure Performance with EXPLAIN or ANALYZE

## Before Index

EXPLAIN ANALYZE
SELECT *
FROM bookings
WHERE user_id = '123';

Take note of the execution time and whether it's doing a sequential scan.

After Creating Index

-- Run this after you've created the indexes
EXPLAIN ANALYZE
SELECT *
FROM bookings
WHERE user_id = '123';
