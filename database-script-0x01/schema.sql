-- Create ENUM types first (if using PostgreSQL)
CREATE TYPE user_role AS ENUM ('guest', 'host', 'admin');
CREATE TYPE booking_status AS ENUM ('pending', 'confirmed', 'canceled');
CREATE TYPE payment_method_type AS ENUM ('credit_card', 'paypal', 'stripe');

-- Locations table
CREATE TABLE Locations (
    location_id UUID PRIMARY KEY,
    city VARCHAR NOT NULL,
    country VARCHAR NOT NULL,
    postal_code VARCHAR,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT unique_location UNIQUE (city, country, postal_code)
);

-- Users table
CREATE TABLE Users (
    user_id UUID PRIMARY KEY,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    email VARCHAR UNIQUE NOT NULL,
    password_hash VARCHAR NOT NULL,
    phone_number VARCHAR,
    role user_role NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Properties table
CREATE TABLE Properties (
    property_id UUID PRIMARY KEY,
    host_id UUID REFERENCES Users(user_id),
    location_id UUID REFERENCES Locations(location_id),
    property_name VARCHAR NOT NULL,
    description TEXT NOT NULL,
    pricepernight DECIMAL NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bookings table
CREATE TABLE Bookings (
    booking_id UUID PRIMARY KEY,
    property_id UUID REFERENCES Properties(property_id),
    user_id UUID REFERENCES Users(user_id),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status booking_status NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Payments table
CREATE TABLE Payments (
    payment_id UUID PRIMARY KEY,
    booking_id UUID REFERENCES Bookings(booking_id),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method payment_method_type NOT NULL
);

-- Reviews table
CREATE TABLE Reviews (
    review_id UUID PRIMARY KEY,
    property_id UUID REFERENCES Properties(property_id),
    user_id UUID REFERENCES Users(user_id),
    rating INTEGER CHECK (rating >= 1 AND rating <= 5) NOT NULL,
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Messages table
CREATE TABLE Messages (
    message_id UUID PRIMARY KEY,
    sender_id UUID REFERENCES Users(user_id),
    recipient_id UUID REFERENCES Users(user_id),
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
