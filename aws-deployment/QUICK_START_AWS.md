# ⚡ Quick Start - AWS Deployment

## 🚀 Fastest Way to Deploy (5 Minutes)

### Prerequisites Check

```bash
# Check AWS CLI
aws --version

# Check AWS credentials
aws sts get-caller-identity
```

If not configured:
```bash
aws configure
```

### Deploy

```bash
cd aws-deployment
chmod +x deploy.sh
./deploy.sh
```

**That's it!** The script will:
1. ✅ Create all AWS resources
2. ✅ Deploy your application
3. ✅ Give you the URL

### Get Your URL

After deployment completes, you'll see:
```
Application URL: http://doc-analyzer-alb-xxxxx.us-east-1.elb.amazonaws.com
```

**Share this URL with your friend!**

---

## 📋 What Gets Created

- ✅ VPC with networking
- ✅ EC2 instance (t3.medium)
- ✅ Application Load Balancer
- ✅ Security groups
- ✅ Auto-starting Flask app

---

## 🔧 Manual Steps (If Script Fails)

1. **Create Key Pair** in EC2 Console
2. **Go to CloudFormation** Console
3. **Create Stack** > Upload `cloudformation-template.yaml`
4. **Fill parameters:**
   - InstanceType: `t3.medium`
   - KeyPairName: Your key pair name
5. **Create Stack**
6. **Wait 10 minutes**
7. **Get URL** from Outputs tab

---

## ✅ Verify Deployment

1. Open the Application URL in browser
2. You should see the Documentation Analyzer interface
3. Try analyzing a URL

---

## 🐛 Troubleshooting

**Can't access URL?**
- Wait 5-10 minutes (EC2 is still setting up)
- Check CloudFormation Events tab
- Verify security group allows port 80

**Need help?**
- See `README_AWS_DEPLOYMENT.md` for detailed guide

---

**That's all! Your app is now on AWS! 🎉**

