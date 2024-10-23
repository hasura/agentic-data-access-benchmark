-- Users table to store account information
CREATE TABLE users (
    user_id BIGSERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    date_of_birth DATE,
    phone_number VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP,
);


-- Emails table for storing message content and metadata
CREATE TABLE emails (
    email_id BIGSERIAL PRIMARY KEY,
    thread_id BIGINT,  -- Groups related emails together
    sender_id BIGINT REFERENCES users(user_id),
    subject VARCHAR(998),  -- Maximum length per RFC 2822
    body TEXT,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_draft BOOLEAN DEFAULT FALSE,
    importance VARCHAR(20),  -- 'high', 'normal', 'low'
    has_attachments BOOLEAN DEFAULT FALSE
);

-- Recipients table for handling multiple recipients
CREATE TABLE email_recipients (
    email_id BIGINT REFERENCES emails(email_id),
    user_id BIGINT REFERENCES users(user_id),
    recipient_type VARCHAR(3), -- 'to', 'cc', 'bcc'
    PRIMARY KEY (email_id, user_id, recipient_type)
);

-- Attachments table for file attachments
CREATE TABLE attachments (
    attachment_id BIGSERIAL PRIMARY KEY,
    email_id BIGINT REFERENCES emails(email_id),
    file_name VARCHAR(255) NOT NULL,
    file_size BIGINT NOT NULL,
    content_type VARCHAR(100),
    storage_path VARCHAR(512),
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- User-specific email metadata
CREATE TABLE user_email_metadata (
    user_id BIGINT REFERENCES users(user_id),
    email_id BIGINT REFERENCES emails(email_id),
    is_read BOOLEAN DEFAULT FALSE,
    is_starred BOOLEAN DEFAULT FALSE,
    is_trash BOOLEAN DEFAULT FALSE,
    is_spam BOOLEAN DEFAULT FALSE,
    custom_sort_order INTEGER,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, email_id)
);


-- Calendars table for multiple calendars per user
CREATE TABLE calendars (
    calendar_id BIGSERIAL PRIMARY KEY,
    owner_id BIGINT REFERENCES users(user_id),
    name VARCHAR(100) NOT NULL,
    description TEXT,
    color VARCHAR(7),  -- Hex color code
    is_primary BOOLEAN DEFAULT FALSE,
    timezone VARCHAR(50) DEFAULT 'UTC',
    is_public BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(owner_id, name)
);

-- Events table for storing calendar events
CREATE TABLE events (
    event_id BIGSERIAL PRIMARY KEY,
    calendar_id BIGINT REFERENCES calendars(calendar_id),
    creator_id BIGINT REFERENCES users(user_id),
    title VARCHAR(255) NOT NULL,
    description TEXT,
    location VARCHAR(255),
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    is_all_day BOOLEAN DEFAULT FALSE,
    recurrence_rule TEXT,  -- iCal RRULE format
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    visibility VARCHAR(20) DEFAULT 'default',  -- 'default', 'public', 'private'
    status VARCHAR(20) DEFAULT 'confirmed',  -- 'confirmed', 'tentative', 'cancelled'
    busy_status VARCHAR(20) DEFAULT 'busy',  -- 'busy', 'free'
    url VARCHAR(2048),  -- For video conference links
    reminders_enabled BOOLEAN DEFAULT TRUE
);

-- Event attendees and their responses
CREATE TABLE event_attendees (
    event_id BIGINT REFERENCES events(event_id),
    user_id BIGINT REFERENCES users(user_id),
    email VARCHAR(255) NOT NULL,  -- For external attendees
    response_status VARCHAR(20) DEFAULT 'pending',  -- 'pending', 'accepted', 'declined', 'tentative'
    is_organizer BOOLEAN DEFAULT FALSE,
    is_optional BOOLEAN DEFAULT FALSE,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    response_updated_at TIMESTAMP,
    PRIMARY KEY (event_id, email)
);


-- Reminders for events
CREATE TABLE reminders (
    reminder_id BIGSERIAL PRIMARY KEY,
    event_id BIGINT REFERENCES events(event_id),
    user_id BIGINT REFERENCES users(user_id),
    reminder_type VARCHAR(20) NOT NULL,  -- 'email', 'notification', 'sms'
    minutes_before INTEGER NOT NULL,  -- Time before event to send reminder
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
