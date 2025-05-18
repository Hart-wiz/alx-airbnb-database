 Query Optimized: SELECT * FROM bookings WHERE user_id = ? AND start_date >= ?

Initial Issues:

Full table scan (Seq Scan)

Slow sorting


Fix Applied:

Added composite index on (user_id, start_date)


Results:

Query switched to Index Scan

Execution time dropped from 520ms to 45ms on a dataset of 100,000+ records


Recommendation: Monitor query plans monthly and add targeted indexes based on query logs.