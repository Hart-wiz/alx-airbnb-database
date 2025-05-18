 -- Get how many bookings each user has made.

SELECT 
    user_id, 
    COUNT(*) AS total_bookings
FROM bookings
GROUP BY user_id;



-- Rank properties by total bookings using ROW_NUMBER()

SELECT 
    p.property_id,
    p.name AS property_name,
    COUNT(b.booking_id) AS total_bookings,
    ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS row_number_rank
FROM properties p
JOIN bookings b ON p.property_id = b.property_id
GROUP BY p.property_id, p.name;