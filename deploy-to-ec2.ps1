# PowerShell script to deploy MEAN app to EC2
# Run this from your local Windows machine

param(
    [Parameter(Mandatory=$true)]
    [string]$EC2_IP = "13.203.193.72",
    
    [Parameter(Mandatory=$true)]
    [string]$SSH_KEY = "meanapp-key-new"
)

Write-Host "=========================================="
Write-Host "MEAN App Deployment to EC2"
Write-Host "=========================================="

# Check if SSH key exists
if (-not (Test-Path $SSH_KEY)) {
    Write-Host "ERROR: SSH key '$SSH_KEY' not found!" -ForegroundColor Red
    exit 1
}

# Check if required files exist
$requiredFiles = @("docker-compose.yml", "nginx.conf", ".env")
foreach ($file in $requiredFiles) {
    if (-not (Test-Path $file)) {
        Write-Host "ERROR: Required file '$file' not found!" -ForegroundColor Red
        exit 1
    }
}

Write-Host "Step 1: Creating application directory on EC2..." -ForegroundColor Green
ssh -i $SSH_KEY ubuntu@$EC2_IP "mkdir -p /home/ubuntu/meanapp"

Write-Host "Step 2: Copying docker-compose.yml..." -ForegroundColor Green
scp -i $SSH_KEY docker-compose.yml ubuntu@${EC2_IP}:/home/ubuntu/meanapp/

Write-Host "Step 3: Copying nginx.conf..." -ForegroundColor Green
scp -i $SSH_KEY nginx.conf ubuntu@${EC2_IP}:/home/ubuntu/meanapp/

Write-Host "Step 4: Copying .env file..." -ForegroundColor Green
scp -i $SSH_KEY .env ubuntu@${EC2_IP}:/home/ubuntu/meanapp/

Write-Host "Step 5: Copying setup script..." -ForegroundColor Green
scp -i $SSH_KEY setup-ec2.sh ubuntu@${EC2_IP}:/home/ubuntu/meanapp/

Write-Host "Step 6: Making setup script executable..." -ForegroundColor Green
ssh -i $SSH_KEY ubuntu@$EC2_IP "chmod +x /home/ubuntu/meanapp/setup-ec2.sh"

Write-Host "Step 7: Running setup script on EC2..." -ForegroundColor Green
ssh -i $SSH_KEY ubuntu@$EC2_IP "cd /home/ubuntu/meanapp && ./setup-ec2.sh"

Write-Host ""
Write-Host "=========================================="
Write-Host "Deployment Complete!"
Write-Host "=========================================="
Write-Host "Application should be accessible at: http://$EC2_IP" -ForegroundColor Cyan
Write-Host ""
Write-Host "To check logs, run:" -ForegroundColor Yellow
Write-Host "ssh -i $SSH_KEY ubuntu@$EC2_IP 'cd /home/ubuntu/meanapp && docker-compose logs -f'" -ForegroundColor Yellow
Write-Host "=========================================="
