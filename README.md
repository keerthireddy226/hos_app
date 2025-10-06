
# Hospital Appointment Management API

This is a Ruby on Rails 8 API-only application for managing hospital appointments, doctors, patients, and notifications. It supports JWT-based authentication, appointment booking, email notifications, and is ready for production deployment with Docker and Kamal.

## Features

- User authentication (JWT)
- Roles: Doctor, Patient
- Book, accept, and cancel appointments
- Email notifications for appointment confirmation and cancellation
- Hospital and doctor management
- API endpoints for all major actions
- Dockerized for easy deployment
- CI/CD and code quality via GitHub Actions

## Tech Stack

- Ruby on Rails 8 (API mode)
- PostgreSQL
- JWT for authentication
- Action Mailer for emails (SMTP/Gmail in dev, SendGrid ready)
- Docker & Kamal for deployment

## Getting Started

### Prerequisites

- Ruby 3.3+
- PostgreSQL
- Node.js & Yarn (for Rails, if needed)
- Docker (for containerized deployment)

### Setup

1. **Clone the repository:**
	```bash
	git clone <repo-url>
	cd hos_app
	```
2. **Install dependencies:**
	```bash
	bundle install
	```
3. **Configure database:**
	Edit `config/database.yml` if needed.
	```bash
	rails db:create db:migrate db:seed
	```
4. **Set up credentials:**
	- Ensure `config/master.key` is present for encrypted credentials.
	- For email, set up SMTP credentials in `config/credentials.yml.enc`.
5. **Run the server:**
	```bash
	rails server -p 3001
	```

### Running with Docker

Build and run the app in a container:
```bash
docker build -t hos_app .
docker run -d -p 80:80 -e RAILS_MASTER_KEY=<your-master-key> --name hos_app hos_app
```

### API Endpoints

#### Authentication
- `POST /login` — User login, returns JWT

#### Patient
- `GET /patients/hospitals` — List all hospitals
- `GET /patients/doctors/:hospital_id` — List doctors in a hospital
- `POST /patients/book_appointment` — Book an appointment (JWT required)

#### Doctor
- `GET /doctors/:id/appointments` — List doctor appointments (JWT required)
- `POST /doctors/:id/accept` — Accept appointment (JWT required)
- `POST /doctors/:id/cancel` — Cancel appointment (JWT required)

### Models

- **User**: Doctor or Patient, has secure password, belongs to hospital (optional for patients)
- **Hospital**: Has many doctors
- **Appointment**: Belongs to doctor, patient, and hospital; validates date

### Email Notifications

Appointment confirmation and cancellation emails are sent to patients using Action Mailer. Configure SMTP in credentials for production.

### Testing

Run all tests:
```bash
rails test
```

### Deployment

- Production deployment is supported via Docker and Kamal.
- See `Dockerfile` and `config/deploy.yml` for details.

### CI/CD

GitHub Actions are set up for linting, security scanning, and tests. See `.github/workflows/ci.yml`.

## License

MIT
