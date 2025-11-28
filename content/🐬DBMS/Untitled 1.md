---
title: Untitled 1
date: 2025-11-26
tags: 
---
# 🎓 TURF-TIME PROJECT - COMPLETE TECHNICAL EXPLANATION

  

## 📚 TABLE OF CONTENTS

1. [Project Architecture Overview](#architecture)

2. [Python Files Explained](#python-files)

3. [How Python Connects to SQL](#python-sql-connection)

4. [What the SQL File Does](#sql-file-explanation)

5. [Data Flow Diagram](#data-flow)

6. [Complete Working Example](#working-example)

  

---

  

<a name="architecture"></a>

## 🏗️ PROJECT ARCHITECTURE OVERVIEW

  

```

USER BROWSER

     ↓

HTML Templates (Jinja2)

     ↓

FLASK ROUTES (auth.py, user.py, owner.py, analytics.py)

     ↓

PYTHON MODELS (models.py) + SQL FEATURES (sql_features.py)

     ↓

SQLALCHEMY ORM + DIRECT SQL QUERIES

     ↓

MYSQL DATABASE (with triggers, views, procedures, functions)

```

  

---

  

<a name="python-files"></a>

## 📁 PYTHON FILES EXPLAINED

  

### 1️⃣ **app.py** - Main Application Entry Point

  

**Purpose:** Creates and configures the Flask application

  

**What it does:**

```python

# Creates Flask app instance

app = Flask(__name__)

  

# Initializes all extensions:

- db (SQLAlchemy) → Database connection

- login_manager (Flask-Login) → User session management

- mail (Flask-Mail) → Email functionality

- moment (Flask-Moment) → Date/time formatting

  

# Registers blueprints (modular routes):

- auth_bp → /auth/* (login, register, password reset)

- user_bp → /user/* (user dashboard, bookings)

- owner_bp → /owner/* (owner dashboard, turfs)

- analytics_bp → /analytics/* (SQL analytics endpoints)

  

# Defines global routes:

- / → Homepage (redirects based on user role)

- /404 → Custom error page

  

# Starts the server when run directly

if __name__ == '__main__':

    app.run(debug=True)

```

  

**Key Functions:**

- `load_user(user_id)` - Loads user from database for Flask-Login

- `create_app()` - Application factory pattern

- `index()` - Root route handler

  

---

  

### 2️⃣ **config.py** - Configuration Management

  

**Purpose:** Centralized configuration using environment variables

  

**What it does:**

```python

# Loads .env file

load_dotenv()

  

# Creates Config class with settings:

- SECRET_KEY → Flask session encryption key

- SQLALCHEMY_DATABASE_URI → MySQL connection string

  Format: mysql+pymysql://username:password@host/database

- MAIL_* → Email server settings (Gmail SMTP)

  

# Validates required environment variables

- Checks if SECRET_KEY, DB credentials, MAIL credentials exist

- Prints error if missing

```

  

**Example Connection String:**

```

mysql+pymysql://root:password@localhost/turf_time

   ↓         ↓      ↓         ↓           ↓

 driver   username password  host     database

```

  

---

  

### 3️⃣ **database/models.py** - ORM Models (Database Tables as Python Classes)

  

**Purpose:** Defines database structure using SQLAlchemy ORM

  

**How it works:**

```python

# Each class = One database table

# Each attribute = One column

  

class User(db.Model):

    __tablename__ = 'users'  # Table name in MySQL

    # Columns

    id = db.Column(db.Integer, primary_key=True)

    username = db.Column(db.String(50), unique=True, nullable=False)

    email = db.Column(db.String(100), unique=True, nullable=False)

    password = db.Column(db.String(255), nullable=False)

    role = db.Column(db.String(20), nullable=False)  # 'user' or 'owner'

    # Relationships (connects tables)

    bookings = db.relationship('Booking', backref='user')

    # This creates: User.bookings → all bookings by this user

    # And: Booking.user → the user who made this booking

```

  

**5 Main Models:**

  

1. **User** → users table

   - Stores user accounts (both customers and owners)

   - Methods: `set_password()`, `check_password()`, `is_owner()`

  

2. **Turf** → turfs table

   - Stores turf listings

   - Connected to User (owner) via `owner_id`

  

3. **Booking** → bookings table

   - Stores booking records

   - Connected to User via `user_id`

   - Connected to Turf via `turf_id`

  

4. **TeamRequest** → team_requests table

   - Stores team join requests

   - Connected to Booking via `booking_id`

   - Connected to User (requester) via `requester_id`

  

5. **PasswordResetOTP** → password_reset_otp table

   - Stores OTP codes for password reset

   - Method: `is_expired()` checks if OTP expired

  

**ORM Example:**

```python

# Create a new user (ORM)

user = User(username='john', email='john@email.com', role='user')

user.set_password('password123')

db.session.add(user)

db.session.commit()

  

# This generates SQL:

INSERT INTO users (username, email, password, role)

VALUES ('john', 'john@email.com', 'hashed_password', 'user');

```

  

---

  

### 4️⃣ **database/db_setup.py** - Raw MySQL Setup (Not Used in Production)

  

**Purpose:** Contains raw SQL CREATE TABLE statements

  

**When used:**

- Initial database setup

- Reference for table structure

- Manual database creation

  

**Why we don't use it:**

- SQLAlchemy ORM automatically creates tables via `db.create_all()`

- This file is just backup/reference

  

---

  

### 5️⃣ **database/sql_features.py** - Advanced SQL Helper Class

  

**Purpose:** Provides Python functions to use SQL views, procedures, and functions

  

**How it works:**

```python

class SQLFeatures:

    @staticmethod

    def get_popular_turfs(limit=10):

        # Queries the SQL VIEW: view_popular_turfs

        query = "SELECT * FROM view_popular_turfs LIMIT :limit"

        result = db.session.execute(text(query), {'limit': limit})

        return [dict(zip(result.keys(), row)) for row in result]

```

  

**Key Methods:**

  

1. **View Queries** (fetch pre-computed data)

   - `get_popular_turfs()` → Most booked turfs

   - `get_owner_revenue()` → Revenue statistics

   - `get_todays_bookings()` → Today's bookings

   - `get_available_turfs()` → Available now

   - `get_monthly_revenue()` → Monthly trends

  

2. **Stored Procedure Calls**

   - `create_booking()` → Create booking with validation

   - `cancel_booking()` → Cancel with refund calculation

   - `get_turf_availability()` → Check slot availability

   - `get_user_stats()` → User statistics

  

3. **Function Calls**

   - `calculate_turf_rating()` → Get turf rating

   - `is_slot_available()` → Check if time slot free

   - `calculate_refund_amount()` → Refund calculation

  

**Example Usage:**

```python

# In routes/analytics.py

from database.sql_features import SQLFeatures

  

@analytics_bp.route('/popular-turfs')

def popular_turfs():

    # Calls SQL view

    turfs = SQLFeatures.get_popular_turfs(limit=10)

    return jsonify({'data': turfs})

```

  

---

  

### 6️⃣ **routes/auth.py** - Authentication Routes

  

**Purpose:** Handles login, registration, password reset

  

**Routes:**

- `/auth/login` (GET, POST) → Login page

- `/auth/register` (GET, POST) → Registration page

- `/auth/logout` → Logout

- `/auth/forgot-password` (GET, POST) → Request OTP

- `/auth/verify-otp` (GET, POST) → Verify OTP and reset password

  

**How Login Works:**

```python

@auth_bp.route('/login', methods=['GET', 'POST'])

def login():

    form = LoginForm()

    if form.validate_on_submit():

        # 1. Query database for user

        user = User.query.filter_by(email=form.email.data).first()

        # 2. Check password

        if user and user.check_password(form.password.data):

            # 3. Log user in (creates session)

            login_user(user, remember=form.remember_me.data)

            # 4. Redirect based on role

            if user.is_owner():

                return redirect(url_for('owner.dashboard'))

            else:

                return redirect(url_for('user.dashboard'))

```

  

**SQL Behind the Scenes:**

```sql

-- form.email.data = 'john@email.com'

SELECT * FROM users WHERE email = 'john@email.com' LIMIT 1;

  

-- If found, check password hash

-- If correct, create session in Flask

```

  

---

  

### 7️⃣ **routes/user.py** - User Routes

  

**Purpose:** User-facing functionality (view turfs, book, manage bookings)

  

**Routes:**

- `/user/dashboard` → User homepage

- `/user/view_turfs` → Browse available turfs (with filters)

- `/user/book_turf/<id>` (GET, POST) → Booking form

- `/user/my_bookings` → View booking history

- `/user/cancel_booking/<id>` → Cancel booking

- `/user/find_teams` → Find public team bookings

- `/user/join_team/<id>` → Join team booking

- `/user/my_team_requests` → View sent/received requests

  

**Booking Creation Process:**

```python

@user_bp.route('/book_turf/<int:turf_id>', methods=['POST'])

def book_turf(turf_id):

    # 1. Get turf details

    turf = Turf.query.get_or_404(turf_id)

    # 2. Calculate price

    duration = (end_time - start_time).hours

    total_price = duration * turf.price_per_hour

    # 3. Check for conflicts (SQL query)

    conflicts = Booking.query.filter(

        Booking.turf_id == turf.id,

        Booking.booking_date == form.booking_date.data,

        Booking.status == 'confirmed',

        # Time overlap logic

    ).all()

    if conflicts:

        flash('Time slot not available')

        return redirect(...)

    # 4. Create booking (ORM)

    booking = Booking(

        turf_id=turf.id,

        user_id=current_user.id,

        booking_date=form.booking_date.data,

        start_time=form.start_time.data,

        end_time=form.end_time.data,

        total_price=total_price,

        status='confirmed'

    )

    db.session.add(booking)

    db.session.commit()

    # 5. Send email notifications

    send_booking_confirmation_email(booking)

    send_booking_notification_to_owner(booking)

```

  

**SQL Generated:**

```sql

-- Step 1: Get turf

SELECT * FROM turfs WHERE id = 8;

  

-- Step 3: Check conflicts

SELECT * FROM bookings

WHERE turf_id = 8

AND booking_date = '2025-11-27'

AND status = 'confirmed'

AND (

    (start_time <= '10:00' AND end_time > '10:00') OR

    (start_time < '12:00' AND end_time >= '12:00') OR

    (start_time >= '10:00' AND end_time <= '12:00')

);

  

-- Step 4: Create booking

INSERT INTO bookings (turf_id, user_id, booking_date, start_time, end_time, total_price, status, created_at)

VALUES (8, 21, '2025-11-27', '10:00', '12:00', 3000.0, 'confirmed', NOW());

  

-- TRIGGER FIRES: trg_calculate_booking_price (already calculated)

-- TRIGGER FIRES: trg_update_turf_stats_on_booking (updates statistics)

-- TRIGGER FIRES: trg_booking_status_change (logs status if changed)

```

  

---

  

### 8️⃣ **routes/owner.py** - Owner Routes

  

**Purpose:** Owner-facing functionality (manage turfs, view bookings, analytics)

  

**Routes:**

- `/owner/dashboard` → Owner homepage with statistics

- `/owner/my_turfs` → List of owned turfs

- `/owner/add_turf` (GET, POST) → Create new turf

- `/owner/edit_turf/<id>` (GET, POST) → Edit turf details

- `/owner/delete_turf/<id>` → Delete turf

- `/owner/bookings` → View all bookings for owned turfs

  

**Dashboard Statistics:**

```python

@owner_bp.route('/dashboard')

def dashboard():

    # 1. Get all turfs owned by current user

    turfs = Turf.query.filter_by(owner_id=current_user.id).all()

    # 2. Get all bookings for those turfs

    turf_ids = [turf.id for turf in turfs]

    bookings = Booking.query.filter(Booking.turf_id.in_(turf_ids)).all()

    # 3. Calculate statistics

    upcoming_bookings = sum(1 for b in bookings if b.booking_date >= today)

    monthly_earnings = sum(b.total_price for b in bookings

                          if b.booking_date >= month_start)

    # 4. Calculate daily earnings (last 7 days)

    daily_earnings = []

    for i in range(7):

        date = today - timedelta(days=i)

        earnings = sum(b.total_price for b in bookings if b.booking_date == date)

        daily_earnings.append(earnings)

```

  

**SQL Behind Dashboard:**

```sql

-- Get turfs

SELECT * FROM turfs WHERE owner_id = 18;

  

-- Get bookings

SELECT * FROM bookings WHERE turf_id IN (1, 2, 3, 4, 5, 6);

  

-- Better way: Use SQL VIEW

SELECT * FROM view_owner_revenue WHERE owner_id = 18;

-- Returns: total_turfs, total_bookings, confirmed_revenue, etc.

```

  

---

  

### 9️⃣ **routes/analytics.py** - Advanced SQL Analytics API

  

**Purpose:** REST API endpoints using advanced SQL features

  

**Routes:**

- `/analytics/popular-turfs` → Top turfs by bookings

- `/analytics/owner/revenue` → Owner revenue stats

- `/analytics/user/stats` → User statistics

- `/analytics/todays-bookings` → Today's bookings

- `/analytics/available-turfs` → Available now

- `/analytics/turf-occupancy` → Occupancy rates

- `/analytics/monthly-revenue` → Monthly trends

- `/analytics/turf/<id>/availability` → Check availability

  

**Example Endpoint:**

```python

@analytics_bp.route('/popular-turfs')

def popular_turfs():

    # Uses SQL VIEW: view_popular_turfs

    turfs = SQLFeatures.get_popular_turfs(limit=10)

    return jsonify({

        'success': True,

        'data': turfs  # List of dict with turf details

    })

```

  

**What happens:**

```python

# Python calls:

SQLFeatures.get_popular_turfs(limit=10)

  

# Which executes SQL:

SELECT * FROM view_popular_turfs LIMIT 10;

  

# view_popular_turfs is defined as:

SELECT

    t.id, t.name, t.location, t.price_per_hour,

    ts.total_bookings, ts.total_revenue, ts.average_rating,

    u.username AS owner_name

FROM turfs t

LEFT JOIN turf_statistics ts ON t.id = ts.turf_id

JOIN users u ON t.owner_id = u.id

ORDER BY ts.total_bookings DESC;

  

# Returns JSON:

{

  "success": true,

  "data": [

    {"id": 1, "name": "Sports Arena", "total_bookings": 45, ...},

    {"id": 3, "name": "City Ground", "total_bookings": 38, ...}

  ]

}

```

  

---

  

### 🔟 **utils/email_utils.py** - Email Functionality

  

**Purpose:** Send HTML email notifications

  

**Key Functions:**

  

1. **send_email(subject, recipients, template, **kwargs)**

   - Generic email sender

   - Uses Flask-Mail or fallback SMTP

   - Renders HTML templates

  

2. **send_booking_confirmation_email(booking)**

   - Sends to user when booking confirmed

   - Template: `templates/emails/booking_confirmation.html`

  

3. **send_booking_notification_to_owner(booking)**

   - Notifies owner of new booking

   - Template: `templates/emails/owner_booking_notification.html`

  

4. **send_cancellation_notification_to_user(booking)**

   - Sends to user when booking cancelled

  

5. **send_password_reset_otp(user, otp)**

   - Sends 6-digit OTP for password reset

  

**How it works:**

```python

def send_booking_confirmation_email(booking):

    subject = f"Booking Confirmation - {booking.turf.name}"

    recipients = [booking.user.email]

    # Render HTML template with booking data

    return send_email(

        subject=subject,

        recipients=recipients,

        template='emails/booking_confirmation.html',

        booking=booking,

        user=booking.user,

        turf=booking.turf,

        booking_date=booking.booking_date.strftime('%A, %d %B %Y'),

        start_time=booking.start_time.strftime('%I:%M %p'),

        end_time=booking.end_time.strftime('%I:%M %p')

    )

```

  

---

  

### 1️⃣1️⃣ **forms.py** - Form Validation

  

**Purpose:** Define HTML forms with server-side validation

  

**Forms:**

  

1. **LoginForm** - Email, password, remember me

2. **RegistrationForm** - Username, email, password, confirm, role

3. **TurfForm** - Name, location, description, price, image

4. **BookingForm** - Date, start time, end time, public/private options

5. **TeamRequestForm** - Message to booking owner

6. **ForgotPasswordForm** - Email for OTP

7. **VerifyOTPForm** - OTP, new password, confirm

  

**How it works:**

```python

class BookingForm(FlaskForm):

    booking_date = DateField('Booking Date', validators=[DataRequired()])

    start_time = TimeField('Start Time', validators=[DataRequired()])

    end_time = TimeField('End Time', validators=[DataRequired()])

    submit = SubmitField('Confirm Booking')

    # Custom validation

    def validate_booking_date(self, booking_date):

        if booking_date.data < date.today():

            raise ValidationError('Cannot book in the past')

    def validate_end_time(self, end_time):

        if self.start_time.data >= end_time.data:

            raise ValidationError('End time must be after start time')

```

  

**In route:**

```python

form = BookingForm()

if form.validate_on_submit():

    # All validations passed

    booking = Booking(

        booking_date=form.booking_date.data,

        start_time=form.start_time.data,

        # ...

    )

```

  

---

  

<a name="python-sql-connection"></a>

## 🔗 HOW PYTHON CONNECTS TO SQL

  

### Connection Layers:

  

```

PYTHON CODE

    ↓

SQLAlchemy ORM (Object-Relational Mapping)

    ↓

PyMySQL Driver

    ↓

MYSQL SERVER

```

  

### Configuration Flow:

  

**1. Environment Variables (.env file):**

```env

DB_USERNAME=root

DB_PASSWORD=password

DB_HOST=localhost

DB_NAME=turf_time

```

  

**2. Config Class (config.py):**

```python

SQLALCHEMY_DATABASE_URI = f'mysql+pymysql://{DB_USERNAME}:{DB_PASSWORD}@{DB_HOST}/{DB_NAME}'

# Result: 'mysql+pymysql://root:password@localhost/turf_time'

```

  

**3. SQLAlchemy Initialization (app.py):**

```python

from database.models import db

  

app = Flask(__name__)

app.config.from_object(Config)

db.init_app(app)  # Connects to database using URI

```

  

**4. Model Definition (models.py):**

```python

class User(db.Model):

    __tablename__ = 'users'

    id = db.Column(db.Integer, primary_key=True)

    username = db.Column(db.String(50), unique=True)

```

  

**5. Using ORM in Routes:**

```python

# ORM Query (Python)

user = User.query.filter_by(email='john@email.com').first()

  

# Behind the scenes, SQLAlchemy generates SQL:

SELECT * FROM users WHERE email = 'john@email.com' LIMIT 1;

  

# Sends SQL to MySQL via PyMySQL driver

# Returns result as Python object

```

  

### Two Ways to Execute SQL:

  

**Method 1: ORM (Object-Relational Mapping)**

```python

# Python code

user = User(username='john', email='john@email.com')

db.session.add(user)

db.session.commit()

  

# SQLAlchemy converts to:

INSERT INTO users (username, email) VALUES ('john', 'john@email.com');

```

  

**Method 2: Raw SQL**

```python

from sqlalchemy import text

  

# Execute raw SQL

result = db.session.execute(

    text("SELECT * FROM view_popular_turfs LIMIT 10")

)

  

# Or with parameters

result = db.session.execute(

    text("SELECT * FROM users WHERE email = :email"),

    {'email': 'john@email.com'}

)

```

  

---

  

<a name="sql-file-explanation"></a>

## 🗄️ WHAT THE SQL FILE DOES (advanced_sql_features.sql)

  

**File:** `database/advanced_sql_features.sql`  

**Size:** 639 lines  

**Purpose:** Creates advanced database features beyond basic tables

  

### Section 1: AUDIT AND ACTIVITY LOGGING TABLES (Lines 1-60)

  

**Creates 4 additional tables:**

  

```sql

-- 1. user_activity_log

-- Tracks all user actions (login, logout, etc.)

CREATE TABLE user_activity_log (

    log_id INT AUTO_INCREMENT PRIMARY KEY,

    user_id INT NOT NULL,

    action_type VARCHAR(50),  -- 'LOGIN', 'BOOKING', 'CANCEL', etc.

    action_description TEXT,

    ip_address VARCHAR(45),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(id)

);

  

-- 2. booking_audit_log

-- Tracks all booking status changes

CREATE TABLE booking_audit_log (

    audit_id INT AUTO_INCREMENT PRIMARY KEY,

    booking_id INT NOT NULL,

    old_status VARCHAR(20),   -- 'confirmed', 'cancelled', etc.

    new_status VARCHAR(20),

    changed_by INT,           -- user_id who made change

    change_reason TEXT,

    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);

  

-- 3. turf_statistics

-- Stores aggregated metrics for each turf

CREATE TABLE turf_statistics (

    stat_id INT AUTO_INCREMENT PRIMARY KEY,

    turf_id INT NOT NULL UNIQUE,

    total_bookings INT DEFAULT 0,

    total_revenue DECIMAL(10, 2) DEFAULT 0,

    average_rating DECIMAL(3, 2) DEFAULT 0,

    last_booked_at TIMESTAMP NULL

);

  

-- 4. price_history

-- Tracks price changes over time

CREATE TABLE price_history (

    history_id INT AUTO_INCREMENT PRIMARY KEY,

    turf_id INT NOT NULL,

    old_price DECIMAL(10, 2),

    new_price DECIMAL(10, 2),

    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);

```

  

**Why these tables:**

- **Audit trail** for compliance and debugging

- **Statistics** for fast analytics (no need to count bookings every time)

- **History** for trend analysis and reports

  

---

  

### Section 2: DATABASE TRIGGERS (Lines 61-160)

  

**5 Triggers that auto-execute on database events:**

  

**Trigger 1: trg_booking_status_change**

```sql

-- WHEN: Booking status changes

-- WHAT: Log it in audit table

CREATE TRIGGER trg_booking_status_change

AFTER UPDATE ON bookings

FOR EACH ROW

BEGIN

    IF OLD.status != NEW.status THEN

        INSERT INTO booking_audit_log (booking_id, old_status, new_status)

        VALUES (NEW.id, OLD.status, NEW.status);

    END IF;

END;

```

  

**Real-world example:**

```sql

-- User cancels booking

UPDATE bookings SET status = 'cancelled' WHERE id = 34;

  

-- Trigger automatically runs:

INSERT INTO booking_audit_log (booking_id, old_status, new_status)

VALUES (34, 'confirmed', 'cancelled');

```

  

**Trigger 2: trg_update_turf_stats_on_booking**

```sql

-- WHEN: New booking created

-- WHAT: Update turf statistics

CREATE TRIGGER trg_update_turf_stats_on_booking

AFTER INSERT ON bookings

FOR EACH ROW

BEGIN

    INSERT INTO turf_statistics (turf_id, total_bookings, total_revenue, last_booked_at)

    VALUES (NEW.turf_id, 1, NEW.total_price, NEW.booking_date)

    ON DUPLICATE KEY UPDATE

        total_bookings = total_bookings + 1,

        total_revenue = total_revenue + NEW.total_price,

        last_booked_at = NEW.booking_date;

END;

```

  

**Trigger 3: trg_update_turf_stats_on_cancel**

```sql

-- WHEN: Booking cancelled

-- WHAT: Adjust statistics (decrease counts)

CREATE TRIGGER trg_update_turf_stats_on_cancel

AFTER UPDATE ON bookings

FOR EACH ROW

BEGIN

    IF OLD.status = 'confirmed' AND NEW.status = 'cancelled' THEN

        UPDATE turf_statistics

        SET total_bookings = total_bookings - 1,

            total_revenue = total_revenue - NEW.total_price

        WHERE turf_id = NEW.turf_id;

    END IF;

END;

```

  

**Trigger 4: trg_log_price_change**

```sql

-- WHEN: Turf price changes

-- WHAT: Save to price history

CREATE TRIGGER trg_log_price_change

AFTER UPDATE ON turfs

FOR EACH ROW

BEGIN

    IF OLD.price_per_hour != NEW.price_per_hour THEN

        INSERT INTO price_history (turf_id, old_price, new_price)

        VALUES (NEW.id, OLD.price_per_hour, NEW.price_per_hour);

    END IF;

END;

```

  

**Trigger 5: trg_calculate_booking_price**

```sql

-- WHEN: Before inserting booking

-- WHAT: Auto-calculate total price

CREATE TRIGGER trg_calculate_booking_price

BEFORE INSERT ON bookings

FOR EACH ROW

BEGIN

    DECLARE turf_price DECIMAL(10, 2);

    DECLARE duration_hours INT;

    -- Get turf price

    SELECT price_per_hour INTO turf_price FROM turfs WHERE id = NEW.turf_id;

    -- Calculate duration

    SET duration_hours = TIMESTAMPDIFF(HOUR, NEW.start_time, NEW.end_time);

    -- Set total price

    SET NEW.total_price = turf_price * duration_hours;

END;

```

  

---

  

### Section 3: DATABASE VIEWS (Lines 161-300)

  

**8 Views for complex queries:**

  

**View 1: view_booking_details**

```sql

-- Complete booking information with JOINs

CREATE VIEW view_booking_details AS

SELECT

    b.id AS booking_id,

    b.booking_date,

    b.start_time,

    b.end_time,

    b.total_price,

    b.status,

    u.username AS user_name,

    u.email AS user_email,

    t.name AS turf_name,

    t.location AS turf_location,

    o.username AS owner_name,

    o.email AS owner_email

FROM bookings b

JOIN users u ON b.user_id = u.id

JOIN turfs t ON b.turf_id = t.id

JOIN users o ON t.owner_id = o.id;

  

-- Usage:

SELECT * FROM view_booking_details WHERE booking_id = 34;

-- Returns all details in one query (no need for 4 separate queries)

```

  

**View 2: view_popular_turfs**

```sql

-- Turfs ranked by booking count

CREATE VIEW view_popular_turfs AS

SELECT

    t.id,

    t.name,

    t.location,

    t.price_per_hour,

    ts.total_bookings,

    ts.total_revenue,

    ts.average_rating,

    u.username AS owner_name

FROM turfs t

LEFT JOIN turf_statistics ts ON t.id = ts.turf_id

JOIN users u ON t.owner_id = u.id

ORDER BY ts.total_bookings DESC;

  

-- Usage:

SELECT * FROM view_popular_turfs LIMIT 10;

-- Returns top 10 most popular turfs

```

  

**View 3: view_owner_revenue**

```sql

-- Revenue stats per owner

CREATE VIEW view_owner_revenue AS

SELECT

    u.id AS owner_id,

    u.username AS owner_name,

    COUNT(DISTINCT t.id) AS total_turfs,

    COUNT(b.id) AS total_bookings,

    SUM(CASE WHEN b.status = 'confirmed' THEN b.total_price ELSE 0 END) AS confirmed_revenue,

    SUM(CASE WHEN b.status = 'cancelled' THEN b.total_price ELSE 0 END) AS cancelled_revenue

FROM users u

JOIN turfs t ON u.id = t.owner_id

LEFT JOIN bookings b ON t.id = b.turf_id

WHERE u.role = 'owner'

GROUP BY u.id;

```

  

**Other Views:**

- **view_user_booking_history** - User statistics

- **view_todays_bookings** - Today's schedule

- **view_available_turfs** - Currently available

- **view_turf_occupancy** - Occupancy rates

- **view_monthly_revenue** - Monthly trends

  

---

  

### Section 4: STORED PROCEDURES (Lines 301-500)

  

**6 Procedures for business logic:**

  

**Procedure 1: sp_create_booking**

```sql

CREATE PROCEDURE sp_create_booking(

    IN p_user_id INT,

    IN p_turf_id INT,

    IN p_booking_date DATE,

    IN p_start_time TIME,

    IN p_end_time TIME,

    OUT p_booking_id INT,

    OUT p_status_message VARCHAR(255)

)

BEGIN

    DECLARE slot_available INT;

    -- Check if slot is available

    SELECT COUNT(*) INTO slot_available

    FROM bookings

    WHERE turf_id = p_turf_id

    AND booking_date = p_booking_date

    AND status = 'confirmed'

    AND (

        (p_start_time >= start_time AND p_start_time < end_time) OR

        (p_end_time > start_time AND p_end_time <= end_time)

    );

    IF slot_available > 0 THEN

        SET p_status_message = 'Time slot not available';

        SET p_booking_id = -1;

    ELSE

        -- Create booking

        INSERT INTO bookings (user_id, turf_id, booking_date, start_time, end_time, status)

        VALUES (p_user_id, p_turf_id, p_booking_date, p_start_time, p_end_time, 'confirmed');

        SET p_booking_id = LAST_INSERT_ID();

        SET p_status_message = 'Booking created successfully';

    END IF;

END;

  

-- Usage from Python:

CALL sp_create_booking(21, 8, '2025-11-27', '10:00', '12:00', @id, @msg);

SELECT @id, @msg;

-- Returns: (34, 'Booking created successfully')

```

  

**Procedure 2: sp_cancel_booking**

```sql

CREATE PROCEDURE sp_cancel_booking(

    IN p_booking_id INT,

    IN p_user_id INT,

    OUT p_status_message VARCHAR(255),

    OUT p_refund_amount DECIMAL(10, 2)

)

BEGIN

    DECLARE hours_until_booking INT;

    DECLARE booking_price DECIMAL(10, 2);

    -- Get booking details

    SELECT total_price, booking_date INTO booking_price, booking_date

    FROM bookings WHERE id = p_booking_id;

    -- Calculate hours until booking

    SET hours_until_booking = TIMESTAMPDIFF(HOUR, NOW(), booking_date);

    -- Refund policy

    IF hours_until_booking > 24 THEN

        SET p_refund_amount = booking_price;  -- 100% refund

    ELSEIF hours_until_booking > 12 THEN

        SET p_refund_amount = booking_price * 0.5;  -- 50% refund

    ELSE

        SET p_refund_amount = 0;  -- No refund

    END IF;

    -- Update booking status

    UPDATE bookings SET status = 'cancelled' WHERE id = p_booking_id;

    SET p_status_message = 'Booking cancelled';

END;

```

  

**Other Procedures:**

- **sp_get_turf_availability** - Check available time slots

- **sp_get_user_stats** - User booking statistics

- **sp_get_revenue_by_date** - Revenue for date range

- **sp_update_turf_rating** - Recalculate ratings

  

---

  

### Section 5: DATABASE FUNCTIONS (Lines 501-600)

  

**6 Functions for calculations:**

  

**Function 1: fn_calculate_turf_rating**

```sql

CREATE FUNCTION fn_calculate_turf_rating(p_turf_id INT)

RETURNS DECIMAL(3, 2)

DETERMINISTIC

BEGIN

    DECLARE avg_rating DECIMAL(3, 2);

    SELECT AVG(rating) INTO avg_rating

    FROM reviews

    WHERE turf_id = p_turf_id;

    RETURN COALESCE(avg_rating, 0);

END;

  

-- Usage:

SELECT fn_calculate_turf_rating(8);

-- Returns: 4.50

```

  

**Function 2: fn_is_slot_available**

```sql

CREATE FUNCTION fn_is_slot_available(

    p_turf_id INT,

    p_date DATE,

    p_start_time TIME,

    p_end_time TIME

) RETURNS BOOLEAN

DETERMINISTIC

BEGIN

    DECLARE conflict_count INT;

    SELECT COUNT(*) INTO conflict_count

    FROM bookings

    WHERE turf_id = p_turf_id

    AND booking_date = p_date

    AND status = 'confirmed'

    AND (

        (p_start_time >= start_time AND p_start_time < end_time) OR

        (p_end_time > start_time AND p_end_time <= end_time)

    );

    RETURN (conflict_count = 0);

END;

  

-- Usage:

SELECT fn_is_slot_available(8, '2025-11-27', '10:00', '12:00');

-- Returns: 1 (true) or 0 (false)

```

  

**Other Functions:**

- **fn_get_user_booking_count** - Count user's bookings

- **fn_calculate_refund_amount** - Refund calculation

- **fn_get_turf_occupancy_rate** - Occupancy percentage

- **fn_get_owner_total_revenue** - Owner's total earnings

  

---

  

### Section 6: INDEXES (Lines 601-639)

  

**15+ Indexes for performance:**

  

```sql

-- Index on foreign keys

CREATE INDEX idx_booking_user ON bookings(user_id);

CREATE INDEX idx_booking_turf ON bookings(turf_id);

CREATE INDEX idx_turf_owner ON turfs(owner_id);

  

-- Index on search fields

CREATE INDEX idx_turf_name ON turfs(name);

CREATE INDEX idx_turf_location ON turfs(location);

CREATE INDEX idx_user_email ON users(email);

  

-- Composite indexes for common queries

CREATE INDEX idx_booking_date_status ON bookings(booking_date, status);

CREATE INDEX idx_booking_turf_date ON bookings(turf_id, booking_date);

  

-- Index on timestamp columns

CREATE INDEX idx_booking_created ON bookings(created_at);

CREATE INDEX idx_user_created ON users(created_at);

```

  

**Why indexes:**

- Speed up JOINs (foreign keys)

- Speed up WHERE clauses (search filters)

- Speed up ORDER BY (sorting)

  

**Example:**

```sql

-- Without index:

SELECT * FROM bookings WHERE user_id = 21;

-- MySQL scans all rows (slow)

  

-- With index on user_id:

SELECT * FROM bookings WHERE user_id = 21;

-- MySQL uses index to jump directly to rows (fast)

```

  

---

  

<a name="data-flow"></a>

## 🔄 COMPLETE DATA FLOW DIAGRAM

  

### Example: User Creates a Booking

  

```

1. USER BROWSER

   └─> Fills booking form on /user/book_turf/8

   └─> Submits: POST /user/book_turf/8

2. FLASK ROUTE (routes/user.py)

   └─> @user_bp.route('/book_turf/<int:turf_id>', methods=['POST'])

   └─> def book_turf(turf_id):

3. FORM VALIDATION (forms.py)

   └─> form = BookingForm()

   └─> if form.validate_on_submit():

       - Check date not in past

       - Check end_time > start_time

4. DATABASE QUERY (ORM)

   └─> turf = Turf.query.get_or_404(8)

   └─> SQL: SELECT * FROM turfs WHERE id = 8;

5. CONFLICT CHECK (ORM)

   └─> conflicts = Booking.query.filter(...)

   └─> SQL: SELECT * FROM bookings

            WHERE turf_id = 8

            AND booking_date = '2025-11-27'

            AND status = 'confirmed'

            AND time_overlap;

6. CREATE BOOKING (ORM)

   └─> booking = Booking(...)

   └─> db.session.add(booking)

   └─> db.session.commit()

   └─> SQL: INSERT INTO bookings (...) VALUES (...);

7. TRIGGERS AUTO-EXECUTE

   └─> trg_calculate_booking_price

       - Calculates total_price before insert

   └─> trg_update_turf_stats_on_booking

       - Updates turf_statistics table

       - SQL: UPDATE turf_statistics SET total_bookings = total_bookings + 1

   └─> trg_booking_status_change

       - Logs to booking_audit_log if status changed

8. SEND EMAILS (utils/email_utils.py)

   └─> send_booking_confirmation_email(booking)

       - Renders HTML template

       - Sends via Gmail SMTP

   └─> send_booking_notification_to_owner(booking)

       - Notifies turf owner

9. RESPONSE TO USER

   └─> flash('Booking confirmed!', 'success')

   └─> redirect(url_for('user.my_bookings'))

10. USER SEES

    └─> My Bookings page with new booking listed

```

  

---

  

<a name="working-example"></a>

## 💡 COMPLETE WORKING EXAMPLE

  

### Scenario: User "john@example.com" books a turf

  

**Step 1: User navigates to turf page**

```

URL: http://localhost:5000/user/view_turfs

```

  

**Python (routes/user.py):**

```python

@user_bp.route('/view_turfs')

def view_turfs():

    turfs = Turf.query.all()

    return render_template('user/view_turfs.html', turfs=turfs)

```

  

**SQL Generated:**

```sql

SELECT * FROM turfs;

```

  

**Result:** Shows list of 6 turfs

  

---

  

**Step 2: User clicks "Book Now" on "Green Valley Sports Arena"**

```

URL: http://localhost:5000/user/book_turf/8

```

  

**Python:**

```python

@user_bp.route('/book_turf/<int:turf_id>', methods=['GET'])

def book_turf(turf_id):

    turf = Turf.query.get_or_404(8)

    form = BookingForm()

    return render_template('user/book_turf.html', turf=turf, form=form)

```

  

**SQL:**

```sql

SELECT * FROM turfs WHERE id = 8;

```

  

**Result:** Shows booking form with turf details

  

---

  

**Step 3: User fills form and submits**

```

Form Data:

- booking_date: 2025-11-27

- start_time: 10:00

- end_time: 12:00

- public_booking: False

- max_players: 0

```

  

**Python:**

```python

@user_bp.route('/book_turf/<int:turf_id>', methods=['POST'])

def book_turf(turf_id):

    turf = Turf.query.get_or_404(8)

    form = BookingForm()

    if form.validate_on_submit():

        # Calculate price

        duration = 2 hours

        total_price = 2 * 1500 = 3000

        # Check conflicts

        conflicts = Booking.query.filter(

            Booking.turf_id == 8,

            Booking.booking_date == '2025-11-27',

            Booking.status == 'confirmed',

            # Time overlap logic

        ).all()

        if not conflicts:

            # Create booking

            booking = Booking(

                turf_id=8,

                user_id=21,  # current_user.id

                booking_date='2025-11-27',

                start_time='10:00',

                end_time='12:00',

                total_price=3000,

                status='confirmed',

                public_booking=False,

                max_players=0,

                current_players=1

            )

            db.session.add(booking)

            db.session.commit()

```

  

**SQL Generated:**

  

```sql

-- Step 1: Get turf

SELECT * FROM turfs WHERE id = 8;

  

-- Step 2: Check conflicts

SELECT * FROM bookings

WHERE turf_id = 8

AND booking_date = '2025-11-27'

AND status = 'confirmed'

AND (

    (start_time <= '10:00:00' AND end_time > '10:00:00') OR

    (start_time < '12:00:00' AND end_time >= '12:00:00') OR

    (start_time >= '10:00:00' AND end_time <= '12:00:00')

);

-- Returns: 0 rows (no conflicts)

  

-- Step 3: Insert booking

INSERT INTO bookings (

    turf_id, user_id, booking_date, start_time, end_time,

    total_price, status, public_booking, max_players,

    current_players, created_at

) VALUES (

    8, 21, '2025-11-27', '10:00:00', '12:00:00',

    3000.00, 'confirmed', 0, 0, 1, NOW()

);

-- Returns: booking_id = 34

  

-- TRIGGER 1: trg_calculate_booking_price (BEFORE INSERT)

-- Already calculated price, no change needed

  

-- TRIGGER 2: trg_update_turf_stats_on_booking (AFTER INSERT)

INSERT INTO turf_statistics (turf_id, total_bookings, total_revenue, last_booked_at)

VALUES (8, 1, 3000.00, '2025-11-27')

ON DUPLICATE KEY UPDATE

    total_bookings = total_bookings + 1,

    total_revenue = total_revenue + 3000.00,

    last_booked_at = '2025-11-27';

```

  

---

  

**Step 4: Send email notifications**

  

**Python:**

```python

send_booking_confirmation_email(booking)

send_booking_notification_to_owner(booking)

```

  

**Email 1: To User (john@example.com)**

```

Subject: Booking Confirmation - Green Valley Sports Arena

  

Dear Parag1337,

  

Your booking for Green Valley Sports Arena has been confirmed.

  

Booking Details:

- Booking ID: 34

- Date: Thursday, 27 November 2025

- Time: 10:00 AM to 12:00 PM

- Amount Paid: ₹3000.0

- Location: Sector 18, Noida

  

[HTML email with styling]

```

  

**Email 2: To Owner (raj@turftime.com)**

```

Subject: New Booking - Green Valley Sports Arena

  

Dear owner_raj,

  

A new booking has been made for your turf Green Valley Sports Arena.

  

Booking Details:

- Booking ID: 34

- Date: Thursday, 27 November 2025

- Time: 10:00 AM to 12:00 PM

- Amount: ₹3000.0

  

Customer Information:

- Name: Parag1337

- Email: paragpanzade0@gmail.com

  

[HTML email with styling]

```

  

---

  

**Step 5: User redirected to My Bookings**

  

```

URL: http://localhost:5000/user/my_bookings

```

  

**Python:**

```python

@user_bp.route('/my_bookings')

def my_bookings():

    bookings = Booking.query.filter_by(user_id=21)\

        .order_by(Booking.booking_date.desc()).all()

    return render_template('user/my_bookings.html', bookings=bookings)

```

  

**SQL:**

```sql

SELECT * FROM bookings

WHERE user_id = 21

ORDER BY booking_date DESC, start_time DESC;

```

  

**Result:** User sees new booking in list

  

---

  

**Step 6: Owner checks analytics**

  

```

URL: http://localhost:5000/analytics/owner/revenue

```

  

**Python (routes/analytics.py):**

```python

@analytics_bp.route('/owner/revenue')

def owner_revenue():

    revenue_data = SQLFeatures.get_owner_revenue(owner_id=18)

    return jsonify({'success': True, 'data': revenue_data[0]})

```

  

**SQL (using VIEW):**

```sql

SELECT * FROM view_owner_revenue WHERE owner_id = 18;

  

-- view_owner_revenue definition:

SELECT

    u.id AS owner_id,

    u.username AS owner_name,

    COUNT(DISTINCT t.id) AS total_turfs,

    COUNT(b.id) AS total_bookings,

    SUM(CASE WHEN b.status = 'confirmed' THEN b.total_price ELSE 0 END) AS confirmed_revenue

FROM users u

JOIN turfs t ON u.id = t.owner_id

LEFT JOIN bookings b ON t.id = b.turf_id

WHERE u.role = 'owner' AND u.id = 18

GROUP BY u.id;

```

  

**JSON Response:**

```json

{

  "success": true,

  "data": {

    "owner_id": 18,

    "owner_name": "owner_raj",

    "total_turfs": 6,

    "total_bookings": 34,

    "confirmed_revenue": 102000.00

  }

}

```

  

---

  

## 🎯 KEY TAKEAWAYS

  

### Python Files:

1. **app.py** - Main Flask app, connects everything

2. **config.py** - Database connection settings

3. **models.py** - Database tables as Python classes (ORM)

4. **sql_features.py** - Helper to use advanced SQL features

5. **routes/** - Handle HTTP requests (auth, user, owner, analytics)

6. **utils/email_utils.py** - Send email notifications

7. **forms.py** - Validate user input

  

### Python → SQL Connection:

1. **SQLAlchemy ORM** - Converts Python objects to SQL

2. **PyMySQL** - Connects Python to MySQL

3. **Raw SQL** - For complex queries (views, procedures, functions)

  

### SQL File Does:

1. **Tables** - Creates audit/statistics tables

2. **Triggers** - Auto-execute on events (5 triggers)

3. **Views** - Pre-computed complex queries (8 views)

4. **Procedures** - Reusable business logic (6 procedures)

5. **Functions** - Custom calculations (6 functions)

6. **Indexes** - Speed up queries (15+ indexes)

  

### How It All Works Together:

```

User Action → Flask Route → Python Code → SQLAlchemy ORM → MySQL Database

                                ↓

                         Triggers Execute

                                ↓

                         Views Update

                                ↓

                         Email Sent

                                ↓

                         Response to User

```

  

---

  

**📌 This is a complete explanation of how your Turf-Time DBMS project works! Every file, every connection, every SQL feature explained in detail. 🚀**
