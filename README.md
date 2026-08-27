# Salon Appointment Scheduler

This project was completed as part of the **Relational Database Certification** from [freeCodeCamp](https://www.freecodecamp.org/).

The goal of the project is to build a command-line appointment scheduler for a salon using **Bash** and **PostgreSQL**.

## Features

- Displays the list of available salon services
- Allows the user to select a service
- Searches for customers by phone number
- Adds new customers to the database when necessary
- Allows customers to choose an appointment time
- Stores appointments in PostgreSQL
- Handles invalid service selections

## Database Structure

The PostgreSQL database contains three main tables:

### `services`

Stores the services offered by the salon.

- `service_id` — Primary key
- `name` — Service name

### `customers`

Stores customer information.

- `customer_id` — Primary key
- `name` — Customer name
- `phone` — Unique customer phone number

### `appointments`

Stores scheduled appointments.

- `appointment_id` — Primary key
- `customer_id` — Foreign key referencing `customers`
- `service_id` — Foreign key referencing `services`
- `time` — Appointment time

## Available Services

The initial database contains:

- Cut
- Color
- Perm
- Style
- Trim

## Technologies Used

- PostgreSQL
- Bash
- SQL
- psql

## Files

- `salon.sh` — Bash script that manages the command-line appointment scheduler
- `salon.sql` — PostgreSQL database dump containing the database structure and initial data

## Running the Project

Restore the PostgreSQL database:

```bash
psql -U postgres < salon.sql
