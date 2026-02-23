# Screenshots Directory

This directory contains screenshots for the project documentation.

## Required Screenshots

Please add the following screenshots to this directory:

### 1. GitHub Actions Workflow Configuration
**Filename**: `github-actions-workflow.png`
- Screenshot of `.github/workflows/deploy.yml` file in GitHub repository
- Should show the workflow configuration code

### 2. Successful CI/CD Pipeline Execution
**Filename**: `github-actions-success.png`
- Screenshot of GitHub Actions tab showing successful workflow run
- Should display all jobs (build, deploy) with green checkmarks

### 3. Docker Hub - Pushed Images
**Filename**: `docker-hub-images.png`
- Screenshot of Docker Hub repository page
- Should show both frontend and backend images with tags (latest, commit SHA)

### 4. Deployed Application UI
**Filename**: `application-ui.png`
- Screenshot of the Angular application homepage in browser
- Should show the application running on EC2 public IP

### 5. Application - Tutorial List
**Filename**: `tutorial-list.png`
- Screenshot showing the list of tutorials in the application
- Should display tutorial entries with title, description, and status

### 6. Application - Add Tutorial
**Filename**: `add-tutorial.png`
- Screenshot of the add/create tutorial form
- Should show input fields for title and description

### 7. Nginx Configuration
**Filename**: `nginx-config.png`
- Screenshot of `nginx.conf` file content
- Should show reverse proxy configuration with upstream definitions

### 8. Docker Compose - Running Containers
**Filename**: `docker-compose-ps.png`
- Screenshot of terminal showing `docker-compose ps` output
- Should display all 4 containers (nginx, frontend, backend, mongodb) with status "Up"

### 9. AWS EC2 Instance
**Filename**: `ec2-instance.png`
- Screenshot of AWS EC2 console
- Should show the running instance with instance ID, type (t2.micro), and public IP

### 10. AWS Security Group Rules
**Filename**: `security-group-rules.png`
- Screenshot of AWS security group inbound rules
- Should show rules for HTTP (port 80) and SSH (port 22)

### 11. Docker Build Process
**Filename**: `docker-build.png`
- Screenshot of terminal showing Docker image build process
- Should display build steps and successful completion

### 12. Application Health Check
**Filename**: `health-check.png`
- Screenshot of terminal or browser showing API health check response
- Should display successful response from `/api/health` or `/api/tutorials` endpoint

## How to Add Screenshots

1. Take screenshots as described above
2. Save them with the exact filenames listed
3. Place them in this `screenshots/` directory
4. The README.md will automatically reference them

## Screenshot Guidelines

- Use high resolution (at least 1920x1080)
- Ensure text is readable
- Crop to show relevant content
- Remove or blur any sensitive information (passwords, API keys, personal IPs)
- Use PNG format for better quality
- Keep file sizes reasonable (< 2MB per image)

## Tools for Taking Screenshots

- **Windows**: Snipping Tool, Win + Shift + S
- **macOS**: Cmd + Shift + 4
- **Linux**: gnome-screenshot, Flameshot
- **Browser**: Browser DevTools screenshot feature
