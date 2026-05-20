# BlissAndGlow - Setup & Installation Guide

## Quick Start

### Prerequisites
- **Java 17+** — [Download JDK 17](https://www.oracle.com/java/technologies/downloads/#java17)
- **Maven 3.8+** — [Download Maven](https://maven.apache.org/download.cgi)
- **MySQL 8** — [Download MySQL](https://dev.mysql.com/downloads/mysql/) or use XAMPP
- **Git** — [Download Git](https://git-scm.com/)
- **Apache Tomcat 10+** — [Download Tomcat](https://tomcat.apache.org/)

---

## Option 1: Local Setup with MySQL (Recommended for Development)

### Step 1: Clone Repository
```bash
git clone https://github.com/anilem58/BlissAndGlow.git
cd BlissAndGlow
```

### Step 2: Set Up Database
```bash
# Start MySQL service (XAMPP / Docker / standalone)

# Create database and import schema
mysql -u root -p < database/schema.sql
mysql -u root -p < database/seed.sql
```

### Step 3: Configure Database Connection
Edit `src/main/resources/db.properties`:
```properties
db.driver=com.mysql.cj.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/blissandglow_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
db.username=root
db.password=your_password
```

### Step 4: Build the Project
```bash
mvn clean install
```

### Step 5: Deploy to Tomcat
```bash
# Copy WAR to Tomcat webapps
cp target/blissandglow.war $TOMCAT_HOME/webapps/

# Start Tomcat
$TOMCAT_HOME/bin/startup.sh        # macOS/Linux
# OR
%TOMCAT_HOME%\bin\startup.bat      # Windows
```

### Step 6: Access Application
```
http://localhost:8080/blissandglow/
```

---

## Option 2: Docker Setup (Production-Ready)

### Prerequisites
- Docker Desktop installed

### Step 1: Clone Repository
```bash
git clone https://github.com/anilem58/BlissAndGlow.git
cd BlissAndGlow
```

### Step 2: Start with Docker Compose
```bash
docker-compose up -d
```

### Step 3: Access Application
```
http://localhost:8080/blissandglow/
```

### Stopping Containers
```bash
docker-compose down
```

---

## Default Test Credentials

### Admin Account
- **Email:** `admin@blissandglow.com`
- **Password:** `admin123`

### Customer Account  
- **Email:** `customer@example.com`
- **Password:** `password123`

---

## Troubleshooting

### MySQL Connection Error
```
Error: Communications link failure
```
**Solution:**
- Verify MySQL is running: `mysql -u root -p`
- Check credentials in `db.properties`
- Verify database exists: `SHOW DATABASES;`

### Port Already in Use
```
Error: Address already in use
```
**Solution:**
- Change Tomcat port in `conf/server.xml`
- Or kill process: `lsof -i :8080` then `kill <PID>`

### Build Fails
```bash
# Clear Maven cache
mvn clean

# Rebuild
mvn clean install -DskipTests
```

### Java Version Error
```bash
# Check Java version
java -version

# Must be 17+
```

---

## Project Structure

```
BlissAndGlow/
├── database/
│   ├── schema.sql        (Database tables & constraints)
│   └── seed.sql          (Sample data)
├── src/main/
│   ├── java/com/blissandglow/
│   │   ├── controller/   (Servlet handlers)
│   │   ├── dao/          (Database access)
│   │   ├── filter/       (Auth & encoding)
│   │   ├── listener/     (Context listener)
│   │   ├── model/        (POJOs)
│   │   ├── service/      (Business logic)
│   │   └── util/         (Utilities)
│   ├── resources/
│   │   └── db.properties (Database config)
│   └── webapp/
│       ├── index.jsp
│       ├── WEB-INF/web.xml
│       ├── WEB-INF/views/
│       └── assets/
├── pom.xml
├── Dockerfile
└── docker-compose.yml
```

---

## Development Commands

```bash
# Build only
mvn clean compile

# Run tests
mvn test

# Package WAR
mvn package

# Skip tests during build
mvn clean package -DskipTests

# Check for dependency updates
mvn versions:display-dependency-updates
```

---

## Support

- Check [README.md](README.md) for project overview
- Review [CONTRIBUTING.md](CONTRIBUTING.md) for development guidelines
- Open [GitHub Issues](https://github.com/anilem58/BlissAndGlow/issues) for problems
