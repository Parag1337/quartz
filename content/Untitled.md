---
title: Untitled
date: 2025-12-09
tags: 
---

# 🔁 COMPLETE FLOW: QR-Based Patient Access System

---

## 🧍‍♂️ 1. Patient Side Flow

### Step 1: Patient Login

- Patient logs into the application using secure authentication (username/password + JWT).
    

### Step 2: Generate QR Code

- Patient clicks **“Generate QR for Doctor”**.
    
- Backend creates a **temporary token (JWT)** containing:
    
    - Patient ID
        
    - Purpose: medical access
        
    - Expiry time (5–10 minutes)
        

### Step 3: QR Display

- The generated token is converted into a QR code.
    
- QR code is displayed on patient’s mobile screen.
    

📌 **Note:** QR does NOT contain medical data.

---

## 👨‍⚕️ 2. Doctor Side Flow

### Step 4: Doctor Login

- Doctor logs into the system.
    
- Doctor identity is verified using authentication.
    

### Step 5: Scan QR Code

- Doctor scans patient’s QR using:
    
    - Mobile camera / tablet / webcam
        

### Step 6: Send Token to Backend

- Scanned QR token is sent to backend API for verification.
    

---

## 🔐 3. Backend Verification Flow (Most Important)

### Step 7: Token Validation

Backend checks:

- ✔ Token signature (not tampered)
    
- ✔ Token expiry time
    
- ✔ Token purpose
    
- ✔ Doctor authentication status
    

```python
jwt.decode(token, SECRET_KEY)
```

### Step 8: Access Decision

- If valid → extract `patient_id`
    
- If expired → deny access
    
- If invalid → deny access
    

---

## 📋 4. Patient Data Access Flow

### Step 9: Fetch Patient Records

- Backend fetches:
    
    - Patient profile
        
    - Medical history
        
    - Prescriptions
        
    - Allergies
        

### Step 10: Display to Doctor

- Doctor dashboard shows patient details.
    
- Doctor can:
    
    - Add prescription
        
    - View history
        
    - Analyze past medications
        

📌 Access is **session-limited**.

---

## 🧾 5. Logging & Security Flow

### Step 11: Access Logging

System logs:

- Doctor ID
    
- Patient ID
    
- Time of access
    
- Purpose
    

### Step 12: Auto Expiry

- Token automatically becomes invalid after expiry.
    
- Doctor cannot reuse QR.
    

---

# 🧠 FLOW DIAGRAM (Text Version)

```
Patient Login
     ↓
Generate Temporary Token
     ↓
Token → QR Code
     ↓
Doctor Scans QR
     ↓
Backend Validates Token
     ↓
Patient Data Access Granted
     ↓
Doctor Prescribes / Views History
     ↓
Session Ends / Token Expires
```

---

# 🔒 SECURITY FEATURES (Mention in Report)

- Time-limited QR token
    
- No medical data in QR
    
- JWT encryption
    
- Doctor authentication mandatory
    
- Access logs maintained
    

---

# 🏥 REAL-WORLD SIMILARITY

- Matches hospital OPD systems
    
- Used in:
    
    - Ayushman Bharat
        
    - eHospital systems
        
    - Modern clinics
        

---

# ✍️ HOW TO WRITE THIS IN PROJECT REPORT

> “The QR-Based Patient Access System enables secure, fast, and paperless retrieval of patient medical records. Patients generate a time-bound QR code containing a secure token. Upon scanning, the backend validates the token and grants doctors authorized access to patient data for the consultation session.”

---

## ✅ FINAL TAKEAWAY

- ✔ Simple logic
    
- ✔ Strong security
    
- ✔ High practical value
    
- ✔ Excellent for viva & demo
    

---

### 👉 Next, I can:

1️⃣ Draw **UML / Sequence diagram**  
2️⃣ Provide **Flask API code flow**  
3️⃣ Write **Module-wise explanation**  
4️⃣ Help integrate with **appointments & prescriptions**

Just tell me what you want next 👍