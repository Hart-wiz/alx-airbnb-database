-- Insert sample data into Location table
INSERT INTO Location (location_id, city, country, postal_code) VALUES
    ('550e8400-e29b-41d4-a716-446655440001', 'New York', 'USA', '10001'),
    ('550e8400-e29b-41d4-a716-446655440002', 'London', 'UK', 'SW1A 1AA'),
    ('550e8400-e29b-41d4-a716-446655440003', 'Paris', 'France', '75001'),
    ('550e8400-e29b-41d4-a716-446655440004', 'Tokyo', 'Japan', '100-0001');

-- Insert sample data into User table
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role) VALUES
    ('550e8400-e29b-41d4-a716-446655440005', 'Alice', 'Smith', 'alice.smith@example.com', 'hash1', '+1234567890', 'guest'),
    ('550e8400-e29b-41d4-a716-446655440006', 'Bob', 'Johnson', 'bob.johnson@example.com', 'hash2', '+1987654321', 'host'),
    ('550e8400-e29b-41d4-a716-446655440007', 'Charlie', 'Brown', 'charlie.brown@example.com', 'hash3', '+1122334455', 'guest'),
    ('550e8400-e29b-41d4-a716-446655440008', 'Diana', 'Wilson', 'diana.wilson@example.com', 'hash4', '+1445566778', 'host'),
    ('550e8400-e29b-41d4-a716-446655440009', 'Eve', 'Davis', 'eve.davis@example.com', 'hash5', '+1555666777', 'admin');

-- Insert sample data into Property table
INSERT INTO Property (property_id, host_id, location_id, name, description, pricepernight) VALUES
    ('550e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440001', 'Cozy NYC Loft', 'A modern loft in the heart of Manhattan.', 150.00),
    ('550e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440002', 'London Flat', 'Charming flat near Big Ben.', 120.00),
    ('550e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440003', 'Parisian Studio', 'Romantic studio with Eiffel Tower view.', 200.00),
    ('550e8400-e29b-41d4-a716-446655440013', '550e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440004', 'Tokyo Apartment', 'Modern apartment in Shibuya.', 180.00);

-- Insert sample data into Booking table
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, status) VALUES
    ('550e8400-e29b-41d4-a716-446655440014', '550e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440005', '2025-06-01', '2025-06-05', 'confirmed'),
    ('550e8400-e29b-41d4-a716-446655440015', '550e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440007', '2025-07-10', '2025-07-15', 'pending'),
    ('550e8400-e29b-41d4-a716-446655440016', '550e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440005', '2025-08-01', '2025-08-07', 'confirmed'),
    ('550e8400-e29b-41d4-a716-446655440017', '550e8400-e29b-41d4-a716-446655440013', '550e8400-e29b-41d4-a716-446655440007', '2025-09-01', '2025-09-03', 'canceled');

-- Insert sample data into Payment table
INSERT INTO Payment (payment_id, booking_id, payment_date, payment_method) VALUES
    ('550e8400-e29b-41d4-a716-446655440018', '550e8400-e29b-41d4-a716-446655440014', '2025-05-20 10:00:00', 'credit_card'),
    ('550e8400-e29b-41d4-a716-446655440019', '550e8400-e29b-41d4-a716-446655440016', '2025-07-25 14:30:00', 'paypal');

-- Insert sample data into Review table
INSERT INTO Review (review_id, property_id, user_id, rating, comment) VALUES
    ('550e8400-e29b-41d4-a716-446655440020', '550e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440005', 5, 'Amazing stay! The loft was clean and cozy.'),
    ('550e8400-e29b-41d4-a716-446655440021', '550e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440005', 4, 'Great location, but a bit noisy at night.');

-- Insert sample data into Message table
INSERT INTO Message (message_id, sender_id, recipient_id, message_body) VALUES
    ('550e8400-e29b-41d4-a716-446655440022', '550e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440006', 'Hi, is the NYC loft available for June?'),
    ('550e8400-e29b-41d4-a716-446655440023', '550e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440005', 'Yes, it’s available! Let me know if you want to book.'),
    ('550e8400-e29b-41d4-a716-446655440024', '550e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440008', 'Can you confirm if the Tokyo apartment has Wi-Fi?');