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

If you use Yarn:

```bash
yarn add card-reader-lite
npx pod-install

---

## 🪄 How to Use

1. iOS Setup: Before building, make sure your app requests camera permissions in Info.plist

```
<key>NSCameraUsageDescription</key>
<string>Card Reader Lite requires camera access to scan your card.</string>
```

2. Import the module: Import the scanCard function from the package

```
import { scanCard } from 'card-reader-lite';
```

3. Call it from a button or action: Trigger the scan with a button press or event handler


```
import React from 'react';
import { Button, View, Alert } from 'react-native';
import { scanCard } from 'card-reader-lite';

export default function App() {
  const handleScan = async () => {
    try {
      const result = await scanCard();
      Alert.alert('Card Scanned!', JSON.stringify(result, null, 2));
      console.log('Card data:', result);
    } catch (error) {
      console.warn('Scan cancelled or failed:', error);
    }
  };

  return (
    <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
      <Button title="Scan Card" onPress={handleScan} />
    </View>
  );
}
```

4. Review the result: When the user completes the scan, the module resolves a Promise with the card data

```
{
  "number": "4111111111111111",
  "expDate": "12/28",
  "holder": "JOHN DOE",
  "brand": "MASTER_CARD"
}
```

---

🧠 Notes
	•	The OCR works best in well-lit environments.
	•	The module doesn’t save or transmit any card data — everything happens locally.
	•	The expiration date and holder name are optional; some cards may not display them in a readable way.
