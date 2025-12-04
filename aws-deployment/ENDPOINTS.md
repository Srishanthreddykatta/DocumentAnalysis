# 🔗 API Endpoints Reference

## Application Endpoints

### Base URL
```
http://<ALB-DNS>/
```
or
```
http://<EC2-PUBLIC-IP>:5000/
```

---

## Available Endpoints

### 1. Home Page
- **URL:** `GET /`
- **Description:** Main web interface
- **Response:** HTML page with documentation analyzer UI
- **Example:**
  ```
  http://doc-analyzer-alb-xxxxx.us-east-1.elb.amazonaws.com/
  ```

### 2. Health Check
- **URL:** `GET /health`
- **Description:** Health check endpoint for load balancer
- **Response:** JSON
  ```json
  {
    "status": "healthy"
  }
  ```
- **Example:**
  ```
  http://doc-analyzer-alb-xxxxx.us-east-1.elb.amazonaws.com/health
  ```

### 3. Analyze Endpoint
- **URL:** `POST /analyze`
- **Description:** Analyze a website URL
- **Content-Type:** `application/json`
- **Request Body:**
  ```json
  {
    "url": "https://example.com/docs/article"
  }
  ```
- **Response:** JSON
  ```json
  {
    "success": true,
    "url": "https://example.com/docs/article",
    "markdown_report": "...",
    "json_report": {...},
    "revised_content": "...",
    "original_content_preview": "..."
  }
  ```
- **Example:**
  ```bash
  curl -X POST http://doc-analyzer-alb-xxxxx.us-east-1.elb.amazonaws.com/analyze \
    -H "Content-Type: application/json" \
    -d '{"url": "https://example.com"}'
  ```

---

## Load Balancer Health Check

The Application Load Balancer uses:
- **Path:** `/health`
- **Protocol:** HTTP
- **Port:** 5000
- **Interval:** 30 seconds
- **Timeout:** 5 seconds
- **Healthy Threshold:** 2 consecutive successes
- **Unhealthy Threshold:** 3 consecutive failures

---

## Testing Endpoints

### Test Health Endpoint
```bash
curl http://<ALB-DNS>/health
```

### Test Analysis Endpoint
```bash
curl -X POST http://<ALB-DNS>/analyze \
  -H "Content-Type: application/json" \
  -d '{"url": "https://docs.yellow.ai/docs/platform_concepts/studio/train/what-is-document-cognition"}'
```

### Test from Browser
1. Open: `http://<ALB-DNS>`
2. Enter URL in input field
3. Click "Analyze"
4. View results

---

## Error Responses

### 400 Bad Request
```json
{
  "error": "URL is required"
}
```

### 500 Internal Server Error
```json
{
  "error": "Failed to fetch article content. Please check the URL and try again."
}
```

---

## Rate Limiting

Currently no rate limiting is configured. For production:
- Consider adding rate limiting via API Gateway
- Or implement in application code
- Recommended: 10 requests/minute per IP

---

## CORS (If Needed)

If accessing from different domain, add CORS headers in `app.py`:

```python
from flask_cors import CORS
CORS(app)
```

---

## SSL/HTTPS Setup (Optional)

1. Request certificate in AWS Certificate Manager
2. Update ALB listener to use HTTPS (port 443)
3. Redirect HTTP to HTTPS
4. Update security group to allow port 443

---

## Monitoring Endpoints

### CloudWatch Metrics
- Request count
- Response time
- Error rate
- Healthy host count

### Access Logs
Enable ALB access logs to S3 for detailed request tracking.

---

**All endpoints are accessible via the Application Load Balancer DNS name!**

