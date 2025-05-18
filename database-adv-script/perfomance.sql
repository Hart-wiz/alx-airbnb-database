
-- Initial complex query to retrieve full booking details
SELECT 
    b.booking_id,
    b.date,
    u.user_id,
    u.name AS user_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    pay.payment_id,
    pay.amount,
    pay.status
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
JOIN payments pay ON b.payment_id = pay.payment_id;

-- Initial complex query to retrieve detail with filter(WHERE, AND)

SELECT
b.booking_id,
    b.date,
    u.name AS user_name,
    u.email,
    p.name AS property_name,
    p.location,
    pay.amount,
    pay.status
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
JOIN payments pay ON b.payment_id = pay.payment_id
WHERE pay.status = 'completed'
  AND p.location = 'Lagos'
  AND b.date >= '2024-01-01';


 -- analyze query performance 
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.date,
    u.user_id,
    u.name,
    p.name,
    pay.amount
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
JOIN payments pay ON b.payment_id = pay.payment_id;



-- Optimized query with only essential fields
SELECT 
    b.booking_id,
    b.date,
    u.name AS user_name,
    p.name AS property_name,
    pay.amount
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
JOIN payments pay ON b.payment_id = pay.payment_id;