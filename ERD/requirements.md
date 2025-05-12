# Requirements

## Entities and Attributes

### User

user_id: Primary Key, UUID, Indexed
first_name: VARCHAR, NOT NULL
last_name: VARCHAR, NOT NULL
email: VARCHAR, UNIQUE, NOT NULL
password_hash: VARCHAR, NOT NULL
phone_number: VARCHAR, NULL
role: ENUM (guest, host, admin), NOT NULL
created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

### Property

property_id: Primary Key, UUID, Indexed
host_id: Foreign Key, references User(user_id)
name: VARCHAR, NOT NULL
description: TEXT, NOT NULL
location: VARCHAR, NOT NULL
pricepernight: DECIMAL, NOT NULL
created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
updated_at: TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP

### Booking

booking_id: Primary Key, UUID, Indexed
property_id: Foreign Key, references Property(property_id)
user_id: Foreign Key, references User(user_id)
start_date: DATE, NOT NULL
end_date: DATE, NOT NULL
total_price: DECIMAL, NOT NULL
status: ENUM (pending, confirmed, canceled), NOT NULL
created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

### Payment

payment_id: Primary Key, UUID, Indexed
booking_id: Foreign Key, references Booking(booking_id)
amount: DECIMAL, NOT NULL
payment_date: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
payment_method: ENUM (credit_card, paypal, stripe), NOT NULL

### Review

review_id: Primary Key, UUID, Indexed
property_id: Foreign Key, references Property(property_id)
user_id: Foreign Key, references User(user_id)
rating: INTEGER, CHECK: rating >= 1 AND rating <= 5, NOT NULL
comment: TEXT, NOT NULL
created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

### Message

message_id: Primary Key, UUID, Indexed
sender_id: Foreign Key, references User(user_id)
recipient_id: Foreign Key, references User(user_id)
message_body: TEXT, NOT NULL
sent_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

---

## 🔗 Relationships Between Entities

---

### 1. **User to Booking**

**Relationship:** One-to-Many

- A **User** (as a guest) can make many **Bookings**.
- A **Booking** is made by one **User**.

> `User.user_id` → `Booking.user_id`

---

### 2. **User to Property**

**Relationship:** One-to-Many

- A **User** (as a host) can create and manage many **Properties**.
- Each **Property** belongs to one **User** (host).

> `User.user_id` → `Property.host_id`

---

### 3. **Property to Booking**

**Relationship:** One-to-Many

- A **Property** can have many **Bookings**.
- Each **Booking** is for one **Property**.

> `Property.property_id` → `Booking.property_id`

---

### 4. **Booking to Payment**

**Relationship:** One-to-One or One-to-Many (depending on your model)

- Each **Booking** can have **one or more Payments**, depending on whether split or installment payments are supported.
- Each **Payment** is tied to a single **Booking**.

> `Booking.booking_id` → `Payment.booking_id`

---

### 5. **Property to Review**

**Relationship:** One-to-Many

- A **Property** can have many **Reviews**.
- Each **Review** is tied to one **Property**.

> `Property.property_id` → `Review.property_id`

---

### 6. **User to Review**

**Relationship:** One-to-Many

- A **User** (as a guest) can write many **Reviews**.
- Each **Review** is written by one **User**.

> `User.user_id` → `Review.user_id`

---

### 7. **User to Message (Self-referencing)**

**Relationship:** Many-to-Many (Modeled as Two One-to-Many relationships)

- A **User** can send many **Messages** and receive many **Messages**.
- Messages have both a `sender_id` and a `recipient_id`, each referencing `User.user_id`.

> `User.user_id` → `Message.sender_id` > `User.user_id` → `Message.recipient_id`

---

### Optional: ERD Diagram
