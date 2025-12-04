#!/bin/bash

# AWS Deployment Script for Documentation Analyzer
# This script automates the deployment process

set -e

echo "=========================================="
echo "AWS Deployment Script"
echo "Documentation Analyzer"
echo "=========================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
STACK_NAME="doc-analyzer-stack"
REGION="us-east-1"
INSTANCE_TYPE="t3.medium"
KEY_PAIR_NAME=""

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo -e "${RED}ERROR: AWS CLI is not installed!${NC}"
    echo "Please install AWS CLI: https://aws.amazon.com/cli/"
    exit 1
fi

# Check if AWS credentials are configured
if ! aws sts get-caller-identity &> /dev/null; then
    echo -e "${RED}ERROR: AWS credentials not configured!${NC}"
    echo "Run: aws configure"
    exit 1
fi

# Get user input
echo -e "${YELLOW}Enter AWS Region (default: us-east-1):${NC}"
read -r input_region
REGION=${input_region:-$REGION}

echo -e "${YELLOW}Enter EC2 Instance Type (default: t3.medium):${NC}"
read -r input_instance
INSTANCE_TYPE=${input_instance:-$INSTANCE_TYPE}

echo -e "${YELLOW}Enter EC2 Key Pair Name (required for SSH access):${NC}"
read -r KEY_PAIR_NAME

if [ -z "$KEY_PAIR_NAME" ]; then
    echo -e "${RED}ERROR: Key Pair Name is required!${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}Configuration:${NC}"
echo "  Stack Name: $STACK_NAME"
echo "  Region: $REGION"
echo "  Instance Type: $INSTANCE_TYPE"
echo "  Key Pair: $KEY_PAIR_NAME"
echo ""

# Deploy CloudFormation stack
echo -e "${YELLOW}Deploying CloudFormation stack...${NC}"
aws cloudformation create-stack \
    --stack-name "$STACK_NAME" \
    --template-body file://cloudformation-template.yaml \
    --parameters \
        ParameterKey=InstanceType,ParameterValue="$INSTANCE_TYPE" \
        ParameterKey=KeyPairName,ParameterValue="$KEY_PAIR_NAME" \
        ParameterKey=AllowedCIDR,ParameterValue="0.0.0.0/0" \
    --capabilities CAPABILITY_NAMED_IAM \
    --region "$REGION"

echo ""
echo -e "${YELLOW}Waiting for stack creation to complete...${NC}"
aws cloudformation wait stack-create-complete \
    --stack-name "$STACK_NAME" \
    --region "$REGION"

# Get outputs
echo ""
echo -e "${GREEN}Stack deployed successfully!${NC}"
echo ""
echo -e "${GREEN}Outputs:${NC}"
aws cloudformation describe-stacks \
    --stack-name "$STACK_NAME" \
    --region "$REGION" \
    --query 'Stacks[0].Outputs' \
    --output table

echo ""
echo -e "${GREEN}Application URL:${NC}"
APP_URL=$(aws cloudformation describe-stacks \
    --stack-name "$STACK_NAME" \
    --region "$REGION" \
    --query 'Stacks[0].Outputs[?OutputKey==`ApplicationURL`].OutputValue' \
    --output text)
echo "$APP_URL"

echo ""
echo -e "${GREEN}Deployment complete!${NC}"
echo "Your application will be available at the URL above in a few minutes."
echo "Note: It may take 5-10 minutes for the EC2 instance to fully set up."

