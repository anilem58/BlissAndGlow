#!/bin/bash

# BlissAndGlow Setup Script for macOS/Linux

set -e

echo "=========================================="
echo "BlissAndGlow - Setup Script"
echo "=========================================="

# Check prerequisites
echo ""
echo "[1/4] Checking prerequisites..."

# Check Java
if ! command -v java &> /dev/null; then
    echo "❌ Java not found. Please install Java 17+"
    exit 1
fi

JAVA_VERSION=$(java -version 2>&1 | head -1)
echo "✓ $JAVA_VERSION"

# Check Git
if ! command -v git &> /dev/null; then
    echo "❌ Git not found. Please install Git"
    exit 1
fi
echo "✓ Git found"

# Build project
echo ""
echo "[2/4] Building project with Maven..."

if [ -f "mvnw" ]; then
    ./mvnw clean install
else
    mvn clean install
fi

echo "✓ Project built successfully"

# Database setup
echo ""
echo "[3/4] Setting up database..."

if command -v mysql &> /dev/null; then
    echo "Enter MySQL credentials:"
    read -p "Username (default: root): " DB_USER
    DB_USER=${DB_USER:-root}
    read -sp "Password: " DB_PASS
    echo ""
    
    if [ -z "$DB_PASS" ]; then
        mysql -u "$DB_USER" < database/schema.sql
        mysql -u "$DB_USER" < database/seed.sql
    else
        mysql -u "$DB_USER" -p"$DB_PASS" < database/schema.sql
        mysql -u "$DB_USER" -p"$DB_PASS" < database/seed.sql
    fi
    echo "✓ Database setup complete"
else
    echo "⚠ MySQL not found. Please manually execute:"
    echo "  mysql -u root -p < database/schema.sql"
    echo "  mysql -u root -p < database/seed.sql"
fi

# Final info
echo ""
echo "[4/4] Setup Information"
echo "=========================================="
echo "Application ready to deploy!"
echo ""
echo "Next steps:"
echo "1. Deploy WAR: target/blissandglow.war to Tomcat"
echo "2. Start Tomcat"
echo "3. Visit: http://localhost:8080/blissandglow/"
echo ""
echo "Or use Docker:"
echo "  docker-compose up -d"
echo "=========================================="
