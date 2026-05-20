# Bliss and Glow — Online Beauty & Cosmetics Web Application

**Module:** CS5054NP — Advanced Programming and Technologies  
**Project:** Bliss and Glow — E-Commerce Web Application  
**Tech stack:** Java EE · Jakarta Servlets · JSP · MySQL · JDBC · Plain CSS

> Tagline: *Beauty. Production. You.*

---

## Project Overview

Bliss and Glow is an online beauty and skincare e-commerce platform built using a strict MVC architecture with Java EE technologies. The system supports two roles:

- **Admin** — manage products, categories, orders, users, and view reports
- **Customer** — register, browse products, search, manage wishlist, and place orders

---

## Tech Stack

| Layer | Technology |
|---|---|
| Language | Java 17 |
| Web Framework | Jakarta Servlets + JSP (no Spring) |
| Database | MySQL 8 via XAMPP |
| Data Access | Raw JDBC with PreparedStatements (no ORM) |
| Build Tool | Maven |
| CSS | Plain CSS (no Bootstrap/Tailwind) |
| Password Hashing | BCrypt (jbcrypt) |
| Server | Apache Tomcat 10 |

---

## Project Structure

```
BlissAndGlow/
├── pom.xml
├── database/
│   ├── schema.sql
│   └── seed.sql
└── src/main/
    ├── java/com/blissandglow/
    │   ├── controller/      (Servlets)
    │   ├── dao/             (JDBC Data Access Objects)
    │   ├── filter/          (Auth + Encoding filters)
    │   ├── listener/        (AppContextListener)
    │   ├── model/           (POJOs)
    │   ├── service/         (Business logic)
    │   └── util/            (DBConnection, PasswordUtil, etc.)
    ├── resources/
    │   └── db.properties
    └── webapp/
        ├── WEB-INF/
        │   ├── web.xml
        │   └── views/
        │       ├── admin/
        │       ├── auth/
        │       ├── common/
        │       ├── error/
        │       └── user/
        ├── assets/
        │   ├── css/style.css
        │   ├── js/main.js
        │   └── images/
        ├── index.jsp
        ├── about.jsp
        └── contact.jsp
```

---

## Setup Instructions

### Prerequisites

- JDK 17 (or 11)
- Apache Tomcat 10.x
- XAMPP (MySQL + phpMyAdmin)
- Maven 3.x

### Step 1 — Set up the database

1. Start XAMPP and enable **Apache** and **MySQL**.
2. Open `http://localhost/phpmyadmin`.
3. Run `database/schema.sql` to create the database and tables.
4. Run `database/seed.sql` to populate 20 products, categories, and a default admin.

**Default admin credentials:**
- Email: `admin@blissandglow.com`
- Password: `Admin@123`

### Step 2 — Configure database connection

Create `src/main/resources/db.properties`:

```properties
db.driver=com.mysql.cj.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/blissandglow_db?useSSL=false&serverTimezone=UTC
db.username=root
db.password=
```

### Step 3 — Build and deploy

```bash
mvn clean package
```

Copy `target/blissandglow.war` to your Tomcat `webapps/` folder, then visit:

```
http://localhost:8080/blissandglow/
```

---

## Features

### Admin
- Dashboard with summary cards (users, products, orders, pending approvals)
- Full product CRUD with image upload
- Category management
- User approval/rejection (PENDING → APPROVED/REJECTED)
- Order status management
- Contact message inbox
- Reports: top products, sales by category, stock comparison

### Customer
- Registration (pending admin approval before login)
- Product browsing with pagination, category filter, sort by price/name
- Product search by name or brand
- Wishlist (session-based for guests, DB-persisted on login)
- Cart and order placement
- Order history with cancellation
- Profile management and password change

---

## Database Schema

Tables: `users`, `categories`, `products`, `orders`, `order_items`, `wishlist`, `contact_messages`

All tables normalized to 3NF. Foreign keys and unique constraints enforced at the database level.

---

## Security

- Passwords hashed with BCrypt before storage
- `AuthFilter` protects `/admin/*` (ADMIN role) and `/user/*` (logged-in CUSTOMER)
- All SQL uses `PreparedStatement` — no string concatenation
- Server-side validation on all forms
- JSPs stored inside `WEB-INF/` — not directly URL-accessible
