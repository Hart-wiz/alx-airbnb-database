 -- Get how many bookings each user has made.

SELECT 
    user_id, 
    COUNT(*) AS total_bookings
FROM bookings
GROUP BY user_id;

-- Rank all properties by how many bookings they’ve received

SELECT 
    p.property_id,
    p.name,
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM properties p
JOIN bookings b ON p.property_id = b.property_id
GROUP BY p.property_id, p.name;