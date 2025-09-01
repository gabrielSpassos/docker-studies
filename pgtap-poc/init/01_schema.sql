SET search_path TO public;

CREATE EXTENSION IF NOT EXISTS pgtap;

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email TEXT NOT NULL UNIQUE,
    active BOOLEAN DEFAULT true,
    balance NUMERIC NOT NULL DEFAULT 0
);

CREATE TABLE accounts (
    id SERIAL PRIMARY KEY,
    user_id SERIAL NOT NULL,
    active BOOLEAN DEFAULT true
);
