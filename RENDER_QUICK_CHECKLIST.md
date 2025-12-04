# ✅ Render.com Deployment - Quick Checklist

## 🔴 CRITICAL - Must Change These!

- [ ] **Language:** Change from "Docker" → **"Python 3"**
- [ ] **Health Check Path:** Change from "/healthz" → **"/health"**

## 📝 Required Fields to Fill

### After Changing to Python 3, you'll see:

- [ ] **Build Command:** 
  ```
  pip install -r moengage_project/codebase/requirements.txt && playwright install chromium && playwright install-deps chromium
  ```

- [ ] **Start Command:**
  ```
  cd moengage_project/codebase && gunicorn --bind 0.0.0.0:$PORT --workers 2 --timeout 300 app:app
  ```

### Optional but Recommended:

- [ ] **Root Directory:** `moengage_project/codebase` (or leave empty)

## ✅ Already Correct (Don't Change)

- [x] **Service Type:** Web Service ✓
- [x] **Name:** DocumentAnalysis ✓
- [x] **Branch:** main ✓
- [x] **Region:** Oregon (US West) ✓
- [x] **Instance Type:** Free ✓
- [x] **GOOGLE_API_KEY:** Already set ✓
- [x] **Auto-Deploy:** On Commit ✓

## 🎯 Final Steps

1. [ ] Make the 2 critical changes above
2. [ ] Fill in Build Command and Start Command
3. [ ] Click **"Deploy Web Service"** button
4. [ ] Wait 5-10 minutes
5. [ ] Copy the URL and share with your friend!

---

**See `RENDER_DEPLOYMENT_STEP_BY_STEP.md` for detailed explanations.**

