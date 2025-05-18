-- Step 1: Drop the original table if it exists (for demo purposes)
DROP TABLE IF EXISTS bookings;

-- Step 2: Create partitioned bookings table based on start_date
CREATE TABLE bookings (
    booking_id SERIAL PRIMARY KEY,
    user_id INT,
    property_id INT,
    payment_id INT,
    start_date DATE,
    end_date DATE
)
PARTITION BY RANGE (start_date);

-- Step 3: Create partitions by year
CREATE TABLE bookings_2023 PARTITION OF bookings
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE bookings_2024 PARTITION OF bookings
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE bookings_2025 PARTITION OF bookings
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Add indexes to partitions if needed
CREATE INDEX idx_bookings_2023_start_date ON bookings_2023(start_date);
CREATE INDEX idx_bookings_2024_start_date ON bookings_2024(start_date);
CREATE INDEX idx_bookings_2025_start_date ON bookings_2025(start_date);

-- Test Query Performance 
EXPLAIN ANALYZE
SELECT * 
FROM bookings
WHERE start_date BETWEEN '2024-04-01' AND '2024-04-30';