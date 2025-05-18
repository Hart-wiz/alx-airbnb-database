Partitioning Performance Report:

> After implementing range-based partitioning on the bookings table by start_date, we observed the following:

Queries that filter by start_date now target only relevant partitions (e.g., bookings_2024), reducing scan time.

The EXPLAIN ANALYZE output showed reduced execution cost and faster query planning time.

Performance improvements were especially noticeable on queries involving date ranges within a single year.


Conclusion: Partitioning the bookings table by year significantly optimized query performance for time-based filters and will scale better as data volume grows