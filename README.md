# Nuojiji - Local Deployment and Packaging

This is a static website mirror of Nuojiji, supporting local development, PWA installation, and packaging into an Android APK.

## 🌟 Project Features

- ✅ Complete static website (latest build, from https://nuojiji.app/)

- ✅ PWA support (can be installed on desktop/home screen)

- ✅ Capacitor configuration (can package Android/iOS App)

- ✅ All resources are localized (fonts, icons, audio)

- ✅ Relative path adaptation (supports subdirectory deployment)

---

## 📱 Quick Start

### Method 1: Local Preview (Web)

**Windows Users:**

```cmd` Double-click to run: one-click start.bat

```

**Command Line:**

```bash` npx serve .

```

Then open `http://localhost:3000` in your browser

### Method 2: Install as PWA

1. Open the website in your browser

2. **Desktop Chrome**: Click the ⊕ install icon on the right side of the address bar

3. **Mobile Phone Chrome**: Click the "Add to Home Screen" banner at the bottom

4. **iOS Safari**: Click the share button → "Add to Home Screen"

### Method 3: Package as an Android APK

See the [Packaging Android APK](#-Packaging-android-apk) section below for details.

---

## 🌐 Deploy to a Server

### GitHub Pages

1. Create a GitHub repository

2. Upload all files in this directory to the repository root directory

3. Push to the `main` branch

4. In the GitHub repository settings: `Settings → Pages`

5. Select `Deploy from a branch` → `main` branch → `/ (root)` directory

6. Save and wait for deployment to complete

### Other Static Hosting

Supports any static hosting service:

- Vercel

- Netlify

- Cloudflare Pages

- Self-hosted server (Nginx/Apache)

**Note**: All resources use relative paths; subdirectory deployment is supported.

---
## ✅ Completed Optimizations

### 1. Full PWA Support

- ✅ Added icons for `pwa-192x192.png` and `pwa-512x512.png`

- ✅ Fixed icon path in manifest.webmanifest

- ✅ All paths changed to relative paths (`./` instead of `/`)

### 2. Resource Localization

- ✅ Font files downloaded to the `assets/` directory

- Montserrat (full @fontsource set, including all formats)

- Cinzel (full @fontsource set, including all formats)

- ✅ Complete audio files

- sent.mp3 (sending tone)

- incoming.mp3 (receiving tone)

- outgoing.mp3 (sending tone)

- notification.mp3 (notification tone)

- woodfish.mp3 (woodfish tone)

- audio/*.mp3 (ambient background sounds: ocean/cafe/night/market/birds)

- ✅ PWA icon files

- ✅ Cover image (nuojiji_comeback_cover.webp)

### 3. Path Fixes

- ✅ All absolute paths (`/xxx`) in JS have been changed to relative paths (`./xxx`)

- ✅ CSS font paths now use relative paths

- ✅ Support for deployment in subdirectories (e.g., `/subfolder/`)

### 4. Login / Lock Screen / Domain Guard Removed

- ✅ Login form, lock screen and password lock are disabled (see `BYPASS_LOGIN_CHANGES.md`)

- ✅ DomainGuard mirror protection removed (no redirect to the official site)

- ✅ Cloudflare Pages analytics/challenge scripts removed

---

---

## 📱 Packaging Android APK

This project is configured with Capacitor, which can package it into a native Android app.

### Prerequisites

1. **Node.js** (Installed ✓)

2. **Android Studio**

- Download: https://developer.android.com/studio

- Launch once after installation to download the Android SDK

### Three-Step Packaging

#### Step 1: Synchronize Static Files to Capacitor

```cmd` Double-click to run: sync-to-www.bat

```
Or command line:

```bash` npm run sync

```
This will copy all files to the `www/` directory and synchronize them to the Android project.

#### Step 2: Open Android Studio

```cmd` Double-click to run: Open AndroidStudio.bat

```
Or command line:

```bash` `npx cap open android`

```

#### Step 3: Compile APK

In Android Studio:

1. Wait for Gradle synchronization to complete (approximately 5-10 minutes for the first time)

2. Click the menu: `Build → Build Bundle(s) / APK(s) → Build APK(s)`

3. Wait for compilation to complete

4. Click "locate" in the lower right corner notification to find the APK

**APK location:**

```android/app/build/outputs/apk/debug/app-debug.apk

```

### Native Features

The packaged app supports all native features:

- ✅ Haptics

- ✅ Open external browser

- ✅ Status Bar Control

- ✅ Local Notifications

- ✅ App Lifecycle

The `window.Capacitor.Plugins` API in the code will work automatically and requires no modification.

### Update the Application

Repackage after website updates:

1. Replace static files in the root directory

2. Run `sync-to-www.bat`

3. Rebuild in Android Studio

### Capacitor Configuration

Configuration file: `capacitor.config.json`

Key configurations:

- `appId: "app.nuojiji"` - Application package name

- `appName: "糯叽机"` - Application name

- `webDir: "www"` - Web resource directory

- `server.hostname: "nuojiji.app"` - CORS spoofed domain

---

## 🔧 Common Issues

### PWA Installation Failure

**Symptoms**: No installation icon in browser address bar

**Solutions**:

1. Confirm file existence:

```
pwa-192x192.png ✓

pwa-512x512.png ✓

```
2. Clear browser cache:

- F12 → Application → Storage → Clear site data

3. Force refresh: Ctrl+Shift+R

4. Check console errors: F12 → Console

### Android Packaging White Screen

**Cause**: Files not synchronized to `www/` directory

**Solution**:

```cmd sync-to-www.bat

```

### Font/Audio Loading Failure

**Cause**: File path problem

**Confirmation**:

- All paths have been changed to relative paths (`./xxx`)

- Files are in the correct location (root directory or `assets/`)

### Cross-Origin (CORS) Error

**Cause**: Backend restricts request origin

**Solution**:

- Capacitor is configured to masquerade as `https://nuojiji.app`

- If the problem persists, contact the backend administrator

---

## 📂 Project Structure

```
nuojiji_local/

├── android/ # Android native project (generated by Capacitor)

├── assets/ # Static resources

│ ├── main-BOFOd43a.js # Main JS file (path fixed, login/guard removed)

│ ├── *.css # Style files

│ ├── *.woff2 / *.woff # Font files (localized)

│ └── ...

├── www/ # Capacitor web directory (synchronization target)

├── audio/ # Ambient background sound files

├── capacitor.config.json # Capacitor configuration

├── index.html # Entry page

├── manifest.webmanifest # PWA manifest (fullscreen)

├── manifest-cn.webmanifest # PWA manifest for CN ROMs (standalone)

├── pwa-192x192.png # PWA icon 192x192

├── pwa-512x512.png # PWA icon 512x512

├── *.mp3 # Audio files

├── sync-to-www.bat # File Synchronization Script

├── Open AndroidStudio.bat # Android Studio startup script

├── One-click Startup.bat # Local server startup script

└── README.md # This file

```

---

## 📚 Related Documents

- [Capacitor Official Documentation](https://capacitorjs.com/docs)

- [PWA Development Guide](https://web.dev/progressive-web-apps/)

- [Android Development Documentation](https://developer.android.com)

---

## 🎯 Checklist

Pre-deployment Confirmations:

- [ ] All PWA icons exist (192x192 and 512x512)

- [ ] All audio files are complete (5 mp3s)

- [ ] Font files are in the assets/ directory

- [ ] The manifest.webmanifest path is correct

- [ ] Test PWA Install Features

- [ ] Test after clearing browser cache

Confirm before packaging:

- [ ] `sync-to-www.bat` has been run

- [ ] Complete files exist in the `www/` directory

- [ ] Android Studio is installed

- [ ] Gradle synchronization successful

---

## 💡 Tips

- First-time Android compilation requires downloading Gradle and dependencies. Please wait patiently.

- Debug APKs are large and have poor performance. Use the Release version for publishing.

- PWAs require HTTPS or localhost to install.

- You can delete the `capacitor-app/` directory (if it exists, it's from a previous test version).

---

**Enjoy using it!** 🎉

For any questions, please see:

- Packaging Guide.md (Detailed Android packaging tutorial)

- BYPASS_LOGIN_CHANGES.md (Login related instructions)
