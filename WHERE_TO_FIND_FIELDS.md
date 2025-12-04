# 📍 Where to Find Each Field on Render.com

## 🔍 Step-by-Step Location Guide

### **Build Command Field Location:**

1. **Look at the page** - You should see a section called **"Build & Start"** or **"Build Settings"**
2. **It's usually right below** the "Root Directory" field
3. **You'll see a text box** labeled **"Build Command"**
4. **Currently it shows:** `pip install -r requirements.txt` (this is wrong)
5. **Click in that text box** and replace it with:
   ```
   pip install -r moengage_project/codebase/requirements.txt && playwright install chromium && playwright install-deps chromium
   ```

### **Visual Guide:**

```
┌─────────────────────────────────────────┐
│ Service Details                         │
├─────────────────────────────────────────┤
│ Select a service type: [Web Service]    │
│ Name: [DocumentAnalysis]                │
│ Language: [Python 3]                    │
│ Branch: [main]                          │
│ Region: [Oregon (US West)]             │
│ Root Directory: [empty]                 │
├─────────────────────────────────────────┤
│ Build & Start Commands  ← LOOK HERE!    │
├─────────────────────────────────────────┤
│ Build Command:                          │
│ ┌─────────────────────────────────────┐ │
│ │ pip install -r requirements.txt    │ │ ← CLICK HERE!
│ └─────────────────────────────────────┘ │
│                                         │
│ Start Command:                          │
│ ┌─────────────────────────────────────┐ │
│ │ gunicorn your_application:wsgi       │ │ ← AND HERE!
│ └─────────────────────────────────────┘ │
└─────────────────────────────────────────┘
```

---

## 📝 Detailed Instructions

### **Finding Build Command:**

1. **Scroll down** on the page after the "Root Directory" field
2. **Look for a section** that says:
   - "Build & Start Commands" OR
   - "Build Settings" OR
   - Just "Build Command" as a label
3. **You'll see a text input box** - it might be a single-line or multi-line text area
4. **Click inside that box** - it should highlight or show a cursor
5. **Delete the current text** (`pip install -r requirements.txt`)
6. **Paste or type** the new command:
   ```
   pip install -r moengage_project/codebase/requirements.txt && playwright install chromium && playwright install-deps chromium
   ```

### **Finding Start Command:**

1. **Right below** the Build Command field
2. **Look for "Start Command"** label
3. **Another text input box** - currently shows: `gunicorn your_application:wsgi`
4. **Click in that box** and replace with:
   ```
   cd moengage_project/codebase && gunicorn --bind 0.0.0.0:$PORT --workers 2 --timeout 300 app:app
   ```

---

## 🎯 Quick Visual Reference

**On the Render.com page, you should see this order:**

```
1. Source Code (top)
2. Service Details
   - Service type
   - Name
   - Language ← You changed this to Python 3
   - Branch
   - Region
   - Root Directory
3. Build & Start Commands ← SCROLL TO HERE
   - Build Command ← FILL THIS
   - Start Command ← FILL THIS
4. Instance Type
5. Environment Variables
6. Advanced (click to expand)
   - Health Check Path ← CHANGE THIS TO /health
```

---

## 💡 Tips

- **If you don't see Build Command:** Make sure you selected "Python 3" as the language
- **The field might be collapsed:** Look for a section header you can click to expand
- **It's a text box:** Just click inside and type/paste
- **Multi-line is OK:** The commands can be on one line

---

## ✅ What It Should Look Like After Filling

**Build Command field:**
```
pip install -r moengage_project/codebase/requirements.txt && playwright install chromium && playwright install-deps chromium
```

**Start Command field:**
```
cd moengage_project/codebase && gunicorn --bind 0.0.0.0:$PORT --workers 2 --timeout 300 app:app
```

---

**If you still can't find it, scroll down on the page - it's definitely there after you select Python 3!**

