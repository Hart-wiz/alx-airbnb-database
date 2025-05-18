-- Indexes for Users table
CREATE INDEX idx_users_user_id ON users(user_id);

-- Indexes for Bookings table
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_date ON bookings(date);

-- Indexes for Properties table
CREATE INDEX idx_properties_property_id ON properties(property_id);
CREATE INDEX idx_properties_name ON properties(name);


-- run this Before creating the  Index
EXPLAIN ANALYZE
SELECT *
FROM bookings
WHERE user_id = '123';

-- Run this after you've created the indexes
EXPLAIN ANALYZE
SELECT *
FROM bookings
WHERE user_id = '123';