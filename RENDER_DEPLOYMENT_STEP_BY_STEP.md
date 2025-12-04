# 📋 Render.com Deployment - Step-by-Step Field Guide

## Field-by-Field Instructions

### ✅ **Source Code** (Already Set)
- **Current:** `Srishanthreddykatta / DocumentAnalysis`
- **Action:** ✅ Already correct - your GitHub repo is connected
- **Note:** If you need to change it, click "Edit" button

---

### 🔧 **Service Details Section**

#### 1. **Select a service type**
- **Current:** "Web Service"
- **Action:** ✅ Keep it as "Web Service" (correct)

#### 2. **Name**
- **Current:** "DocumentAnalysis"
- **Action:** ✅ Keep it or change to something shorter like "doc-analyzer"
- **Recommendation:** Keep "DocumentAnalysis" (it's fine)

#### 3. **Language** ⚠️ **IMPORTANT - NEEDS TO CHANGE**
- **Current:** "Docker"
- **Action:** ❌ **CHANGE THIS!** Click dropdown and select **"Python 3"**
- **Why:** Your app is a Flask/Python app, not Docker
- **Note:** After changing, you'll see different fields appear

#### 4. **Branch**
- **Current:** "main"
- **Action:** ✅ Keep "main" (correct)

#### 5. **Region**
- **Current:** "Oregon (US West)"
- **Action:** ✅ Keep it (good for US users) OR choose closest to your friend
- **Options:** 
  - Oregon (US West) - Good for US
  - Frankfurt (EU) - Good for Europe
  - Singapore (Asia Pacific) - Good for Asia

#### 6. **Root Directory (Optional)**
- **Current:** Empty
- **Action:** ✅ **LEAVE EMPTY** or enter: `moengage_project/codebase`
- **Why:** Your Flask app is in `moengage_project/codebase/`
- **Note:** If you set this, Render will run commands from this directory

---

### 💻 **Build & Start Commands** (Appear after selecting Python 3)

After changing Language to "Python 3", you'll see these fields:

#### **Build Command**
- **Enter this EXACTLY:**
  ```bash
  pip install -r moengage_project/codebase/requirements.txt && playwright install chromium && playwright install-deps chromium
  ```
- **What it does:** Installs Python packages and Playwright browser

#### **Start Command**
- **Enter this EXACTLY:**
  ```bash
  cd moengage_project/codebase && gunicorn --bind 0.0.0.0:$PORT --workers 2 --timeout 300 app:app
  ```
- **What it does:** Starts the Flask app using Gunicorn
- **Note:** `$PORT` is automatically set by Render

---

### 💰 **Instance Type Section**

#### **Selected: Free**
- **Current:** "Free" ($0/month)
- **Action:** ✅ **Keep "Free"** for testing
- **Limitations:**
  - Spins down after 15 minutes of inactivity
  - First request after spin-down takes ~30 seconds
  - 512 MB RAM, 0.1 CPU
- **For Production:** Consider "Starter" ($7/month) for always-on

---

### 🔐 **Environment Variables Section**

#### **GOOGLE_API_KEY**
- **Current:** Already set (masked with asterisks)
- **Action:** ✅ **VERIFY** it shows: `AIzaSyCSD6T2I7Gk3ZEV5-hWqkT3yQgRc--P45g`
- **If not set or wrong:**
  1. Click "Edit" or delete and re-add
  2. Key: `GOOGLE_API_KEY`
  3. Value: `AIzaSyCSD6T2I7Gk3ZEV5-hWqkT3yQgRc--P45g`
  4. Click "Save"

---

### ⚙️ **Advanced Section** (Click to expand)

#### **Health Check Path**
- **Current:** "/healthz"
- **Action:** ❌ **CHANGE TO:** `/health`
- **Why:** Your Flask app has route `/health`, not `/healthz`

#### **Auto-Deploy**
- **Current:** "On Commit"
- **Action:** ✅ Keep "On Commit" (auto-updates when you push to GitHub)

#### **Docker Settings** (Ignore these - you're using Python)
- **Docker Build Context Directory:** Leave as "." (won't be used)
- **Dockerfile Path:** Leave as "." (won't be used)
- **Docker Command:** Leave empty (won't be used)

#### **Pre-Deploy Command** (Optional)
- **Action:** ✅ Leave empty (not needed)

#### **Build Filters** (Optional)
- **Action:** ✅ Leave empty (not needed)

---

## 📝 **Complete Configuration Summary**

Here's what your final configuration should look like:

```
Service Type: Web Service
Name: DocumentAnalysis
Language: Python 3 ⚠️ (Change from Docker!)
Branch: main
Region: Oregon (US West)
Root Directory: moengage_project/codebase (or leave empty)

Build Command:
pip install -r moengage_project/codebase/requirements.txt && playwright install chromium && playwright install-deps chromium

Start Command:
cd moengage_project/codebase && gunicorn --bind 0.0.0.0:$PORT --workers 2 --timeout 300 app:app

Instance Type: Free

Environment Variables:
GOOGLE_API_KEY = AIzaSyCSD6T2I7Gk3ZEV5-hWqkT3yQgRc--P45g

Health Check Path: /health ⚠️ (Change from /healthz)
Auto-Deploy: On Commit
```

---

## 🚨 **Critical Changes Needed**

1. ❌ **Change Language from "Docker" to "Python 3"**
2. ❌ **Change Health Check Path from "/healthz" to "/health"**
3. ✅ **Add Build Command** (after changing to Python 3)
4. ✅ **Add Start Command** (after changing to Python 3)
5. ✅ **Verify GOOGLE_API_KEY** is correct

---

## ✅ **After Configuration**

1. Click **"Deploy Web Service"** button (purple button at bottom)
2. Wait 5-10 minutes for first deployment
3. You'll see build logs in real-time
4. Once deployed, you'll get a URL like: `https://documentanalysis.onrender.com`
5. **Share this URL with your friend!**

---

## 🐛 **Troubleshooting**

**If build fails:**
- Check build logs for errors
- Verify Build Command is correct
- Make sure all files are pushed to GitHub

**If app doesn't start:**
- Check Start Command is correct
- Verify Health Check Path is `/health`
- Check environment variables are set

**If timeout errors:**
- Increase timeout in Start Command: `--timeout 600`
- Or upgrade to paid instance

---

## 📞 **Need Help?**

- Check build logs in Render dashboard
- Verify all files are in GitHub repo
- Test locally first: `test_local.bat`

