# ✅ AWS Deployment Checklist

Use this checklist to ensure successful deployment.

## Pre-Deployment

- [ ] AWS account created and active
- [ ] AWS CLI installed (`aws --version`)
- [ ] AWS credentials configured (`aws configure`)
- [ ] EC2 Key Pair created in AWS Console
- [ ] Key pair file (.pem) saved securely
- [ ] Repository cloned: `git clone https://github.com/Srishanthreddykatta/DocumentAnalysis.git`
- [ ] Navigated to deployment folder: `cd DocumentAnalysis/aws-deployment`

## Deployment Steps

### Option 1: Automated Script

- [ ] Made script executable: `chmod +x deploy.sh`
- [ ] Ran deployment script: `./deploy.sh`
- [ ] Entered AWS region (default: us-east-1)
- [ ] Entered instance type (default: t3.medium)
- [ ] Entered key pair name
- [ ] Waited for stack creation (5-10 minutes)
- [ ] Copied Application URL from output

### Option 2: CloudFormation Console

- [ ] Opened AWS CloudFormation Console
- [ ] Clicked "Create stack"
- [ ] Selected "Upload a template file"
- [ ] Uploaded `cloudformation-template.yaml`
- [ ] Filled stack name: `doc-analyzer-stack`
- [ ] Set parameters:
  - [ ] InstanceType: `t3.medium`
  - [ ] KeyPairName: (your key pair)
  - [ ] AllowedCIDR: `0.0.0.0/0`
- [ ] Acknowledged IAM resource creation
- [ ] Clicked "Create stack"
- [ ] Waited for stack creation (5-10 minutes)
- [ ] Checked "Outputs" tab for Application URL

## Post-Deployment Verification

- [ ] Application URL accessible in browser
- [ ] Home page loads correctly
- [ ] Health endpoint works: `http://<URL>/health`
- [ ] Test analysis with sample URL works
- [ ] Results display correctly

## Security Checklist

- [ ] Security group restricts access (if needed)
- [ ] API key is set correctly in environment
- [ ] EC2 instance has proper IAM role
- [ ] Key pair file permissions set: `chmod 400 your-key.pem`

## Monitoring Setup

- [ ] CloudWatch logs accessible
- [ ] EC2 instance status: Running
- [ ] Application Load Balancer: Active
- [ ] Health checks: Passing

## Documentation

- [ ] Application URL saved
- [ ] EC2 instance IP noted
- [ ] Key pair file location noted
- [ ] Stack name documented

## Troubleshooting (If Needed)

- [ ] Checked CloudFormation Events tab
- [ ] Verified EC2 instance is running
- [ ] Checked security group rules
- [ ] Reviewed application logs
- [ ] Tested SSH access to EC2

## Final Steps

- [ ] Shared Application URL with friend
- [ ] Documented any custom configurations
- [ ] Set up monitoring alerts (optional)
- [ ] Created backup of configuration

---

## Quick Reference

**Application URL Format:**
```
http://doc-analyzer-alb-<random>.us-east-1.elb.amazonaws.com
```

**SSH Access:**
```bash
ssh -i your-key.pem ec2-user@<EC2-PUBLIC-IP>
```

**View Logs:**
```bash
sudo journalctl -u doc-analyzer -f
```

**Restart Service:**
```bash
sudo systemctl restart doc-analyzer
```

---

**✅ All checked? Your deployment is complete!**

