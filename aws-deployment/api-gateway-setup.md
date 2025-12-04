# API Gateway Setup (Optional)

If you want to expose the application via API Gateway for additional features:

## Benefits

- Custom domain support
- API throttling and rate limiting
- Request/response transformation
- API versioning
- Usage plans and API keys

## Setup Steps

### 1. Create API Gateway

```bash
aws apigateway create-rest-api \
    --name doc-analyzer-api \
    --description "Documentation Analyzer API" \
    --endpoint-configuration types=REGIONAL
```

### 2. Create Resources

```bash
# Get API ID
API_ID=$(aws apigateway get-rest-apis \
    --query 'items[?name==`doc-analyzer-api`].id' \
    --output text)

# Create root resource
ROOT_ID=$(aws apigateway get-resources \
    --rest-api-id $API_ID \
    --query 'items[?path==`/`].id' \
    --output text)

# Create proxy resource
aws apigateway create-resource \
    --rest-api-id $API_ID \
    --parent-id $ROOT_ID \
    --path-part "{proxy+}"
```

### 3. Create Integration

```bash
# Get ALB DNS from CloudFormation
ALB_DNS=$(aws cloudformation describe-stacks \
    --stack-name doc-analyzer-stack \
    --query 'Stacks[0].Outputs[?OutputKey==`LoadBalancerDNS`].OutputValue' \
    --output text)

# Create HTTP integration
aws apigateway put-integration \
    --rest-api-id $API_ID \
    --resource-id $PROXY_ID \
    --http-method ANY \
    --type HTTP_PROXY \
    --integration-http-method ANY \
    --uri "http://${ALB_DNS}/{proxy}" \
    --request-parameters '{"integration.request.path.proxy": "method.request.path.proxy"}'
```

### 4. Deploy API

```bash
aws apigateway create-deployment \
    --rest-api-id $API_ID \
    --stage-name prod
```

### 5. Get API URL

```bash
aws apigateway get-stage \
    --rest-api-id $API_ID \
    --stage-name prod \
    --query 'invokeUrl' \
    --output text
```

## Custom Domain (Optional)

1. **Request Certificate** in AWS Certificate Manager
2. **Create Custom Domain** in API Gateway
3. **Map Domain** to API stage
4. **Update DNS** records

---

**Note:** For most use cases, the ALB URL is sufficient. API Gateway adds complexity but provides additional features.

