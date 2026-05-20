# Contributing to BlissAndGlow

Thank you for your interest in contributing to the BlissAndGlow project!

## Development Setup

1. Follow the [SETUP.md](SETUP.md) guide to set up your local environment
2. Create a feature branch from `main`
3. Make your changes
4. Submit a pull request

## Code Guidelines

### Java Conventions
- **Classes:** PascalCase (e.g., `UserDAO`, `ProductService`)
- **Methods/Variables:** camelCase (e.g., `getUserById()`, `isValidEmail`)
- **Constants:** UPPER_SNAKE_CASE (e.g., `MAX_UPLOAD_SIZE`)
- **Packages:** lowercase (e.g., `com.blissandglow.controller`)

### Commit Messages
Follow this format:
```
[TYPE] Brief description

TYPE: feat, fix, docs, refactor, test, chore
Examples:
- [feat] Add product review system
- [fix] Resolve payment gateway error
- [docs] Update setup instructions
```

### Code Organization
- **controller/** — Servlet HTTP handlers
- **dao/** — Database access objects (JDBC)
- **service/** — Business logic
- **model/** — POJOs and entity classes
- **filter/** — Authentication and encoding filters
- **util/** — Reusable utilities and helpers

### Best Practices
- Use PreparedStatements for SQL queries (prevents SQL injection)
- Hash passwords with BCrypt
- Validate user input on server-side
- Use try-catch with meaningful error messages
- Add Javadoc comments for public methods
- Keep methods focused and reasonably sized

## Testing

Before submitting changes:
```bash
mvn clean test
mvn clean package
```

## Security

- Never commit database credentials
- Use environment variables for sensitive config
- Validate and sanitize all user inputs
- Use HTTPS in production
- Implement CSRF protection where applicable

## Reporting Issues

Include:
1. Clear title describing the issue
2. Steps to reproduce
3. Expected vs actual behavior
4. Screenshots/logs if applicable
5. Java/MySQL version used

## Questions?

- Review [README.md](README.md)
- Check [SETUP.md](SETUP.md)
- Open a GitHub Discussion or Issue

---

Thank you for contributing! 🎉
