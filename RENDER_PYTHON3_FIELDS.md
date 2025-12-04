# 📋 Render.com - Python 3 Configuration Fields

## ✅ Exact Values to Fill (After Selecting Python 3)

### 🔧 **Service Details Section**

#### 1. **Select a service type**
- **Value:** `Web Service`
- **Status:** ✅ Already correct - keep it

#### 2. **Name**
- **Value:** `DocumentAnalysis`
- **Status:** ✅ Already correct - keep it

#### 3. **Language**
- **Value:** `Python 3`
- **Status:** ✅ You already changed this - perfect!

#### 4. **Branch**
- **Value:** `main`
- **Status:** ✅ Already correct - keep it

#### 5. **Region**
- **Value:** `Oregon (US West)`
- **Status:** ✅ Already correct - keep it

#### 6. **Root Directory (Optional)**
- **Value:** `moengage_project/codebase`
- **OR leave it EMPTY** (both work)
- **Status:** ⚠️ Optional - you can leave empty or add the path

---

### 🔨 **Build & Start Commands** (Most Important!)

#### 7. **Build Command** ⚠️ **MUST CHANGE**
- **Current (Wrong):** `pip install -r requirements.txt`
- **Change To (Copy This Exactly):**
  ```
  pip install -r moengage_project/codebase/requirements.txt && playwright install chromium && playwright install-deps chromium
  ```
- **What it does:** 
  - Installs all Python packages
  - Installs Playwright browser (needed for web scraping)

#### 8. **Start Command** ⚠️ **MUST CHANGE**
- **Current (Wrong):** `gunicorn your_application:wsgi`
- **Change To (Copy This Exactly):**
  ```
  cd moengage_project/codebase && gunicorn --bind 0.0.0.0:$PORT --workers 2 --timeout 300 app:app
  ```
- **What it does:**
  - Changes to the app directory
  - Starts Flask app using Gunicorn
  - Uses 2 workers for better performance
  - Sets 300 second timeout (5 minutes) for long analyses

---

### 💰 **Instance Type**

#### 9. **Instance Type**
- **Value:** `Free` (selected)
- **Status:** ✅ Keep "Free" for now
- **Note:** Free tier spins down after 15 min inactivity, but works fine for testing

---

### 🔐 **Environment Variables**

#### 10. **GOOGLE_API_KEY**
- **Key:** `GOOGLE_API_KEY`
- **Value:** `AIzaSyCSD6T2I7Gk3ZEV5-hWqkT3yQgRc--P45g`
- **Status:** ✅ Already set (showing as masked)
- **Action:** Verify it's there, if not, add it

---

### ⚙️ **Advanced Section** (Click to expand if needed)

#### 11. **Health Check Path** ⚠️ **MUST CHANGE**
- **Current (Wrong):** `/healthz`
- **Change To:** `/health`
- **Why:** Your Flask app has route `/health`, not `/healthz`

#### 12. **Pre-Deploy Command**
- **Value:** Leave **EMPTY**
- **Status:** ✅ Not needed

#### 13. **Auto-Deploy**
- **Value:** `On Commit`
- **Status:** ✅ Already correct - keep it
- **What it does:** Auto-deploys when you push to GitHub

#### 14. **Build Filters**
- **Included Paths:** Leave empty
- **Ignored Paths:** Leave empty
- **Status:** ✅ Not needed

---

## 📝 **Quick Copy-Paste Commands**

### Build Command:
```bash
pip install -r moengage_project/codebase/requirements.txt && playwright install chromium && playwright install-deps chromium
```

### Start Command:
```bash
cd moengage_project/codebase && gunicorn --bind 0.0.0.0:$PORT --workers 2 --timeout 300 app:app
```

---

## ✅ **Final Checklist**

Before clicking "Deploy Web Service", verify:

- [x] Language: **Python 3** ✅
- [ ] Build Command: **Updated** (copy from above)
- [ ] Start Command: **Updated** (copy from above)
- [ ] Health Check Path: **Changed to `/health`**
- [x] GOOGLE_API_KEY: **Already set** ✅
- [x] Branch: **main** ✅
- [x] Instance Type: **Free** ✅

---

## 🚀 **After Filling Everything**

1. ✅ Double-check Build Command and Start Command
2. ✅ Change Health Check Path to `/health`
3. ✅ Click **"Deploy Web Service"** button (purple button at bottom)
4. ⏳ Wait 5-10 minutes for first deployment
5. 📋 Copy the URL (will be like: `https://documentanalysis.onrender.com`)
6. 📤 Share URL with your friend!

---

## 🐛 **Common Mistakes to Avoid**

❌ **Don't use:** `pip install -r requirements.txt`  
✅ **Use:** `pip install -r moengage_project/codebase/requirements.txt && playwright install chromium && playwright install-deps chromium`

❌ **Don't use:** `gunicorn your_application:wsgi`  
✅ **Use:** `cd moengage_project/codebase && gunicorn --bind 0.0.0.0:$PORT --workers 2 --timeout 300 app:app`

❌ **Don't use:** `/healthz`  
✅ **Use:** `/health`

---

## 💡 **Pro Tips**

- **Root Directory:** You can leave it empty OR set to `moengage_project/codebase` - both work!
- **Timeout:** 300 seconds (5 minutes) is enough for most analyses
- **Workers:** 2 workers handle multiple requests better
- **Free Tier:** First request after spin-down takes ~30 seconds (normal)

---

**Once you fill these fields correctly, click "Deploy Web Service" and you're done!** 🎉

