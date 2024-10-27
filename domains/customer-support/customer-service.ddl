-- Users table
CREATE TABLE Users (
    id UUID PRIMARY KEY,
    email TEXT NOT NULL,
    customer_id TEXT UNIQUE NOT NULL,
    max_project_limit INTEGER,
    created_at TIMESTAMPTZ NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL,
    zendesk_user_id TEXT,
    organization_id TEXT,
    first_name TEXT,
    last_name TEXT
);

-- Projects table
CREATE TABLE Projects (
    id UUID PRIMARY KEY,
    name TEXT NOT NULL,
    owner_id UUID NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL,
    deleted_at TIMESTAMPTZ,
    active_models INTEGER NOT NULL,
    active_commands INTEGER NOT NULL,
    FOREIGN KEY (owner_id) REFERENCES Users(id)
);

-- Invoice table
CREATE TABLE Invoice (
    stripe_invoice_id TEXT PRIMARY KEY,
    customer_id TEXT NOT NULL,
    subscription_id TEXT,
    month INTEGER NOT NULL,
    year INTEGER NOT NULL,
    description TEXT,
    status TEXT NOT NULL,
    invoice_url TEXT,
    attempt_count INTEGER,
    created_at TIMESTAMPTZ NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Users(customer_id)
);

-- Invoice item table
CREATE TABLE Invoice_item (
    id UUID PRIMARY KEY,
    invoice_id TEXT NOT NULL,
    amount NUMERIC NOT NULL,
    description TEXT,
    project_id UUID NOT NULL,
    type TEXT NOT NULL,
    month INTEGER NOT NULL,
    year INTEGER NOT NULL,
    has_updated_to_stripe BOOLEAN NOT NULL,
    error TEXT,
    created_at TIMESTAMPTZ NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL,
    FOREIGN KEY (invoice_id) REFERENCES Invoice(stripe_invoice_id),
    FOREIGN KEY (project_id) REFERENCES Projects(id)
);

-- Project Entitlement Catalog table
CREATE TABLE Project_Entitlement_Catalog (
    id UUID PRIMARY KEY,
    type TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL,
    config_limit INTEGER,
    config_is_enabled BOOLEAN,
    name TEXT NOT NULL,
    base_cost NUMERIC
);

-- Project Entitlement Access table
CREATE TABLE Project_Entitlement_Access (
    id UUID PRIMARY KEY,
    project_id UUID NOT NULL,
    entitlement_id UUID NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL,
    deleted_at TIMESTAMPTZ,
    FOREIGN KEY (project_id) REFERENCES Projects(id),
    FOREIGN KEY (entitlement_id) REFERENCES Project_Entitlement_Catalog(id)
);

-- Plans table
CREATE TABLE Plans (
    id UUID PRIMARY KEY,
    name TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL
);

-- Plan Entitlement Access table
CREATE TABLE Plan_Entitlement_Access (
    id UUID PRIMARY KEY,
    plan_id UUID NOT NULL,
    entitlement_id UUID NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    FOREIGN KEY (plan_id) REFERENCES Plans(id),
    FOREIGN KEY (entitlement_id) REFERENCES Project_Entitlement_Catalog(id)
);

-- Project Plan Changelogs table
CREATE TABLE Project_Plan_Changelogs (
    id UUID PRIMARY KEY,
    plan_id UUID NOT NULL,
    project_id UUID NOT NULL,
    comment TEXT,
    created_at TIMESTAMPTZ NOT NULL,
    FOREIGN KEY (plan_id) REFERENCES Plans(id),
    FOREIGN KEY (project_id) REFERENCES Projects(id)
);


CREATE TABLE  Requests_Daily_Count (
    project_id  UUID,
    date DATE NOT NULL,
    request_count INTEGER NOT NULL,
    PRIMARY KEY (project_id, date),
    FOREIGN KEY (project_id) REFERENCES Projects(id)
);


CREATE TABLE IF NOT EXISTS Error_Rate_Daily (
    project_id  UUID ,
    date DATE NOT NULL,
    success_count INTEGER,
    error_count INTEGER,
    error_rate FLOAT,
    PRIMARY KEY (project_id, date),
    FOREIGN KEY (project_id) REFERENCES Projects(id)    
);

CREATE TABLE IF NOT EXISTS Support_User (
    id INTEGER PRIMARY KEY,
    email text,
    role text
);

CREATE TABLE IF NOT EXISTS Support_Ticket (
    id INTEGER PRIMARY KEY,
    is_public BOOLEAN NOT NULL,
    priority TEXT,
    status TEXT,
    subject TEXT,
    description TEXT,
    type TEXT,
    assignee_id INTEGER,
    requester_id INTEGER,
    created_at TIMESTAMPTZ,
    url TEXT,
    FOREIGN KEY (assignee_id) REFERENCES Support_User(id),
    FOREIGN KEY (requester_id) REFERENCES Support_User(id)
);

CREATE TABLE IF NOT EXISTS Support_Ticket_Comment (
    id INTEGER PRIMARY KEY,
    body TEXT,
    created_at TIMESTAMPTZ,
    user_id INTEGER,
    FOREIGN KEY (user_id) REFERENCES Support_User(id)
);
