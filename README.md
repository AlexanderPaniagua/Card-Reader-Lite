# 📸 Card Reader Lite

> **A lightweight Expo module for credit card scanning on iOS**  
> Built with Swift + Vision, inspired by [michzio/CardScanner](https://github.com/michzio/CardScanner)

---

## ⚙️ Overview

**Card Reader Lite** is an iOS-only Expo module that allows React Native / Expo apps to scan credit or debit cards using the device camera.  
It leverages **Apple’s Vision framework** for OCR-based number detection and returns structured card information.

---

## 🧩 Features

- 🧠 **Native iOS Vision-based OCR** for card number recognition  
- 📱 Presents a native Swift camera view controller  
- 🧩 Designed as an **Expo Module** (no React Native bridge boilerplate)  
- 🚀 Lightweight – no external dependencies  
- 🔒 Privacy-respecting – no data sent externally  

---

## 📱 Platform Support

| Platform | Supported |
|-----------|------------|
| iOS       | ✅ Yes (15.1+) |
| Android   | ❌ Not yet supported |
| Web       | ❌ Not applicable |

> ℹ️ This module is designed **only for iOS** at the moment.

---

## 📦 Installation

```bash
npm install card-reader-lite
npx pod-install