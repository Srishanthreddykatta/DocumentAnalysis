# 🚀 AWS Deployment Guide - Documentation Analyzer

Complete guide to deploy the Documentation Analyzer Flask application on AWS.

## 📋 Prerequisites

Before starting, ensure you have:

1. **AWS Account** - Sign up at https://aws.amazon.com
2. **AWS CLI** - Install from https://aws.amazon.com/cli/
3. **AWS Credentials** - Configure using `aws configure`
4. **EC2 Key Pair** - Create one in AWS Console (EC2 > Key Pairs)
5. **Git** - To clone the repository

---

## 🏗️ Architecture Overview

The deployment creates:

- **VPC** with public subnets across 2 availability zones
- **Application Load Balancer** for high availability
- **EC2 Instance** running the Flask application
- **Security Groups** for network security
- **IAM Roles** for EC2 permissions
- **S3 Bucket** for application artifacts (optional)

---

## 📝 Step-by-Step Deployment

### Step 1: Prepare AWS Account

1. **Login to AWS Console**
   - Go to https://console.aws.amazon.com
   - Sign in with your credentials

2. **Create EC2 Key Pair**
   - Navigate to: **EC2** > **Key Pairs** > **Create Key Pair**
   - Name: `doc-analyzer-key` (or any name you prefer)
   - Type: RSA
   - Format: `.pem` (for Linux/Mac) or `.ppk` (for Windows)
   - Click **Create Key Pair**
   - **Save the downloaded file securely** - you'll need it for SSH access

3. **Configure AWS CLI**
   ```bash
   aws configure
   ```
   Enter:
   - AWS Access Key ID
   - AWS Secret Access Key
   - Default region: `us-east-1` (or your preferred region)
   - Default output format: `json`

### Step 2: Clone Repository

```bash
git clone https://github.com/Srishanthreddykatta/DocumentAnalysis.git
cd DocumentAnalysis/aws-deployment
```

### Step 3: Deploy Using CloudFormation

#### Option A: Automated Script (Recommended)

```bash
chmod +x deploy.sh
./deploy.sh
```

The script will prompt you for:
- AWS Region (default: us-east-1)
- EC2 Instance Type (default: t3.medium)
- Key Pair Name (required)

#### Option B: Manual CloudFormation

1. **Go to AWS CloudFormation Console**
   - Navigate to: https://console.aws.amazon.com/cloudformation

2. **Create Stack**
   - Click **"Create stack"** > **"With new resources (standard)"**
   - Choose **"Upload a template file"**
   - Upload `cloudformation-template.yaml`
   - Click **Next**

3. **Specify Stack Details**
   - Stack name: `doc-analyzer-stack`
   - Parameters:
     - **InstanceType**: `t3.medium` (or your choice)
     - **KeyPairName**: Your EC2 key pair name
     - **AllowedCIDR**: `0.0.0.0/0` (for public access)
   - Click **Next**

4. **Configure Stack Options**
   - Leave defaults or add tags
   - Click **Next**

5. **Review and Create**
   - Review all settings
   - Check **"I acknowledge that AWS CloudFormation might create IAM resources"**
   - Click **"Create stack"**

6. **Wait for Completion**
   - Stack creation takes 5-10 minutes
   - Watch the **Events** tab for progress

### Step 4: Get Application URL

After stack creation completes:

1. Go to **Outputs** tab in CloudFormation
2. Copy the **ApplicationURL** value
3. Your app will be available at that URL

**Example URL:** `http://doc-analyzer-alb-123456789.us-east-1.elb.amazonaws.com`

---

## 🔧 Manual EC2 Deployment (Alternative)

If you prefer to deploy manually on an existing EC2 instance:

### Step 1: Launch EC2 Instance

1. **EC2 Console** > **Launch Instance**
2. **Name**: `doc-analyzer`
3. **AMI**: Amazon Linux 2023
4. **Instance Type**: t3.medium (minimum)
5. **Key Pair**: Select your key pair
6. **Network Settings**: 
   - Allow HTTP (port 80)
   - Allow HTTPS (port 443)
   - Allow SSH (port 22)
   - Allow Custom TCP (port 5000)
7. **Launch Instance**

### Step 2: Connect to EC2

```bash
ssh -i your-key.pem ec2-user@<EC2-PUBLIC-IP>
```

### Step 3: Install Dependencies

```bash
# Update system
sudo yum update -y

# Install Python 3.11
sudo yum install -y python3.11 python3.11-pip git

# Install Playwright system dependencies
sudo yum install -y nss atk at-spi2-atk cups-libs libdrm libxkbcommon \
    libxcomposite libxdamage libxfixes libxrandr libgbm libxshmfence alsa-lib
```

### Step 4: Deploy Application

```bash
# Clone repository
cd /home/ec2-user
git clone https://github.com/Srishanthreddykatta/DocumentAnalysis.git
cd DocumentAnalysis/moengage_project/codebase

# Install Python dependencies
pip3.11 install -r requirements.txt

# Install Playwright browsers
playwright install chromium
playwright install-deps chromium
```

### Step 5: Create Systemd Service

```bash
sudo nano /etc/systemd/system/doc-analyzer.service
```

Add this content:

```ini
[Unit]
Description=Documentation Analyzer Flask App
After=network.target

[Service]
Type=simple
User=ec2-user
WorkingDirectory=/home/ec2-user/DocumentAnalysis/moengage_project/codebase
Environment="GOOGLE_API_KEY=AIzaSyCSD6T2I7Gk3ZEV5-hWqkT3yQgRc--P45g"
Environment="PORT=5000"
ExecStart=/usr/bin/python3.11 app.py
Restart=always

[Install]
WantedBy=multi-user.target
```

### Step 6: Start Service

```bash
sudo systemctl daemon-reload
sudo systemctl enable doc-analyzer
sudo systemctl start doc-analyzer
sudo systemctl status doc-analyzer
```

### Step 7: Configure Security Group

1. Go to **EC2** > **Security Groups**
2. Select your instance's security group
3. **Inbound Rules** > **Edit**
4. Add rule:
   - Type: Custom TCP
   - Port: 5000
   - Source: 0.0.0.0/0
5. Save

### Step 8: Access Application

Open browser: `http://<EC2-PUBLIC-IP>:5000`

---

## 🌐 Using Application Load Balancer (Recommended)

For production, use the ALB created by CloudFormation:

1. **Get ALB DNS** from CloudFormation Outputs
2. **Access**: `http://<ALB-DNS>`
3. ALB automatically routes to EC2 instance

---

## 🔐 Security Best Practices

### 1. Update Security Groups

Restrict access to specific IPs:

```bash
# Update CloudFormation parameter
AllowedCIDR: "YOUR_IP/32"  # Replace with your IP
```

### 2. Use HTTPS (Optional)

1. **Request SSL Certificate** in AWS Certificate Manager
2. **Update ALB Listener** to use HTTPS (port 443)
3. **Redirect HTTP to HTTPS**

### 3. Environment Variables

For production, use AWS Systems Manager Parameter Store:

```bash
# Store API key securely
aws ssm put-parameter \
    --name "/doc-analyzer/google-api-key" \
    --value "AIzaSyCSD6T2I7Gk3ZEV5-hWqkT3yQgRc--P45g" \
    --type "SecureString"
```

Then update EC2 User Data to retrieve it.

---

## 📊 Monitoring & Logs

### CloudWatch Logs

View application logs:

```bash
# SSH into EC2
ssh -i your-key.pem ec2-user@<EC2-IP>

# View service logs
sudo journalctl -u doc-analyzer -f
```

### CloudWatch Metrics

- EC2 instance metrics (CPU, Memory, Network)
- ALB metrics (Request count, Response time)
- Health check status

---

## 🔄 Updating the Application

### Method 1: Via Git (Recommended)

```bash
# SSH into EC2
ssh -i your-key.pem ec2-user@<EC2-IP>

# Update code
cd /home/ec2-user/DocumentAnalysis
git pull origin main

# Restart service
sudo systemctl restart doc-analyzer
```

### Method 2: Update CloudFormation Stack

1. Make changes to `cloudformation-template.yaml`
2. Update stack in CloudFormation Console
3. Upload new template
4. Stack will update automatically

---

## 🗑️ Cleanup / Delete Stack

To remove all resources:

```bash
aws cloudformation delete-stack \
    --stack-name doc-analyzer-stack \
    --region us-east-1
```

Or via Console:
1. Go to CloudFormation
2. Select stack
3. Click **Delete**

---

## 🐛 Troubleshooting

### Application Not Accessible

1. **Check Security Groups**
   - Ensure port 5000 (or 80 for ALB) is open
   - Verify source IP is allowed

2. **Check EC2 Status**
   ```bash
   ssh -i your-key.pem ec2-user@<EC2-IP>
   sudo systemctl status doc-analyzer
   ```

3. **Check Application Logs**
   ```bash
   sudo journalctl -u doc-analyzer -n 50
   ```

4. **Check Health Endpoint**
   ```bash
   curl http://localhost:5000/health
   ```

### Playwright Issues

If Playwright fails:

```bash
# Reinstall Playwright browsers
playwright install chromium
playwright install-deps chromium
```

### Port Already in Use

```bash
# Find process using port 5000
sudo lsof -i :5000

# Kill process
sudo kill -9 <PID>
```

---

## 💰 Cost Estimation

**Free Tier Eligible:**
- t3.micro instance (750 hours/month free for 12 months)
- 5 GB S3 storage
- 15 GB data transfer

**Estimated Monthly Cost (after free tier):**
- t3.medium EC2: ~$30/month
- Application Load Balancer: ~$16/month
- Data Transfer: ~$0.09/GB
- **Total: ~$50-60/month** (depending on usage)

---

## 📞 Support

For issues:
1. Check CloudFormation Events tab
2. Review EC2 system logs
3. Check application logs
4. Verify security group rules

---

## ✅ Deployment Checklist

- [ ] AWS account created
- [ ] AWS CLI installed and configured
- [ ] EC2 Key Pair created
- [ ] Repository cloned
- [ ] CloudFormation stack deployed
- [ ] Application URL obtained
- [ ] Application accessible in browser
- [ ] Health endpoint working (`/health`)
- [ ] Test analysis with sample URL

---

## 🎉 Success!

Once deployed, your application will be:
- ✅ Accessible via public URL
- ✅ Running on scalable infrastructure
- ✅ Monitored via CloudWatch
- ✅ Auto-restarting on failure
- ✅ Ready for production use

**Share the Application URL with your friend!**

