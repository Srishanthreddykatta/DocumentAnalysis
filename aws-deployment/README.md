# 🚀 AWS Deployment Package

Complete AWS deployment solution for Documentation Analyzer.

## 📦 What's Included

### Core Files
- **`cloudformation-template.yaml`** - Complete AWS infrastructure as code
- **`deploy.sh`** - Automated deployment script
- **`ec2-user-data.sh`** - EC2 initialization script

### Documentation
- **`README_AWS_DEPLOYMENT.md`** - Complete deployment guide
- **`QUICK_START_AWS.md`** - 5-minute quick start
- **`DEPLOYMENT_CHECKLIST.md`** - Step-by-step checklist
- **`ENDPOINTS.md`** - API endpoints reference
- **`api-gateway-setup.md`** - Optional API Gateway setup

---

## ⚡ Quick Start

```bash
cd aws-deployment
chmod +x deploy.sh
./deploy.sh
```

**That's it!** Your app will be deployed in 10 minutes.

---

## 📋 Prerequisites

1. AWS Account
2. AWS CLI installed and configured
3. EC2 Key Pair created
4. Git (to clone repository)

---

## 🏗️ What Gets Deployed

- ✅ VPC with public subnets
- ✅ Application Load Balancer
- ✅ EC2 instance (t3.medium)
- ✅ Security groups
- ✅ IAM roles
- ✅ Auto-starting Flask application

---

## 📖 Documentation

1. **New to AWS?** → Start with `QUICK_START_AWS.md`
2. **Need detailed guide?** → Read `README_AWS_DEPLOYMENT.md`
3. **Want checklist?** → Use `DEPLOYMENT_CHECKLIST.md`
4. **API reference?** → See `ENDPOINTS.md`

---

## 🎯 Deployment Options

### Option 1: Automated Script (Recommended)
```bash
./deploy.sh
```

### Option 2: CloudFormation Console
1. Upload `cloudformation-template.yaml`
2. Fill parameters
3. Create stack

### Option 3: Manual EC2
Follow manual steps in `README_AWS_DEPLOYMENT.md`

---

## 🔗 After Deployment

You'll get an Application URL like:
```
http://doc-analyzer-alb-xxxxx.us-east-1.elb.amazonaws.com
```

**Share this URL with your friend!**

---

## 💰 Cost

- **Free Tier:** t3.micro (first 12 months)
- **Production:** ~$50-60/month (t3.medium + ALB)

---

## 🆘 Support

- Check `DEPLOYMENT_CHECKLIST.md` for troubleshooting
- Review CloudFormation Events tab
- Check EC2 system logs

---

## ✅ Success Criteria

- [ ] Stack created successfully
- [ ] Application URL accessible
- [ ] Health endpoint returns 200
- [ ] Can analyze a test URL

---

**Ready to deploy? Start with `QUICK_START_AWS.md`!**

