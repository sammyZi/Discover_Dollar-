In this DevOps task, you need to build and deploy a full-stack CRUD application using the MEAN stack (MongoDB, Express, Angular 15, and Node.js). The backend will be developed with Node.js and Express to provide REST APIs, connecting to a MongoDB database. The frontend will be an Angular application utilizing HTTPClient for communication.  

The application will manage a collection of tutorials, where each tutorial includes an ID, title, description, and published status. Users will be able to create, retrieve, update, and delete tutorials. Additionally, a search box will allow users to find tutorials by title.

## Project setup

### Node.js Server

cd backend

npm install

You can update the MongoDB credentials by modifying the `db.config.js` file located in `app/config/`.

Run `node server.js`

### Angular Client

cd frontend

npm install

Run `ng serve --port 8081`

You can modify the `src/app/services/tutorial.service.ts` file to adjust how the frontend interacts with the backend.

Navigate to `http://localhost:8081/`

## CI/CD Pipeline Setup

This project includes a GitHub Actions workflow for automated building and deployment.

### Required GitHub Secrets

To enable the CI/CD pipeline, configure the following secrets in your GitHub repository settings (Settings → Secrets and variables → Actions → New repository secret):

| Secret Name | Description | Example Value |
|-------------|-------------|---------------|
| `DOCKER_USERNAME` | Your Docker Hub username | `johndoe` |
| `DOCKER_PASSWORD` | Your Docker Hub password or access token | `dckr_pat_xxxxx` (recommended: use access token) |
| `EC2_HOST` | Public IP address of your EC2 instance | `54.123.45.67` |
| `EC2_SSH_KEY` | Private SSH key for EC2 access | Contents of your `.pem` file |

### Setting Up GitHub Secrets

1. Navigate to your GitHub repository
2. Click on **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Enter the secret name and value
5. Click **Add secret**
6. Repeat for all four required secrets

### Docker Hub Access Token (Recommended)

Instead of using your Docker Hub password, create an access token:

1. Log in to [Docker Hub](https://hub.docker.com/)
2. Go to **Account Settings** → **Security** → **Access Tokens**
3. Click **New Access Token**
4. Give it a description (e.g., "GitHub Actions")
5. Copy the token and use it as `DOCKER_PASSWORD` secret

### Workflow Triggers

The CI/CD pipeline automatically triggers on:
- Push to `main` or `master` branch
- Manual trigger via GitHub Actions UI (workflow_dispatch)

### Pipeline Stages

1. **Build**: Builds Docker images for frontend and backend, pushes to Docker Hub
2. **Deploy**: Connects to EC2 via SSH, pulls latest images, restarts containers
3. **Health Check**: Verifies the application is running correctly
