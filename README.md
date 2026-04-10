# 🏦 Dashen Bank Mobile App

A modern, feature-rich mobile banking application built with Flutter, replicating the Dashen Bank user interface with enhanced functionality.

![Flutter Version](https://img.shields.io/badge/Flutter-3.0+-blue.svg)
![Dart Version](https://img.shields.io/badge/Dart-3.0+-blue.svg)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-brightgreen.svg)

## 📱 Screenshots

<img width="618" height="948" alt="image" src="https://github.com/user-attachments/assets/962042d1-7c8d-4bd6-8b13-6040875f28a0" />
<img width="615" height="913" alt="image" src="https://github.com/user-attachments/assets/5e7bd20f-43cb-47a7-9319-d05dcdd32d6a" />
<img width="612" height="873" alt="image" src="https://github.com/user-attachments/assets/71ca1353-77f5-45e6-a496-7ef364dc91c9" />
<img width="623" height="903" alt="image" src="https://github.com/user-attachments/assets/63fa8415-099b-465f-9cd8-420dab4a4c31" />


| PIN Login Screen | Home Screen | Transaction Screen |
|-----------------|-------------|-------------------|
| PIN entry with 5-digit security | Dashboard with account overview | Transaction history |

## ✨ Features

### 🔐 Security Features
- **5-digit PIN Authentication** - Secure login with PIN entry
- **Hide/Show Balance** - Balance hidden by default, toggle visibility with eye icon
- **Copy Account Number** - One-tap copy account number to clipboard
- **Account Number Privacy** - Account number hidden by default (shown as ******)

### 🏠 Home Screen
- **Welcome Message** - Personalized greeting with user name
- **User Profile Card** - Display user information and account details
- **Quick Actions Grid** - 8 banking services:
  - Send To Dashen
  - Send To Other (IPS)
  - Send To Wallet
  - Micro Finance
  - Mobile Top-up
  - Bill Payments
  - Merchant Payment
  - See More
- **3 Click E-commerce** - Product showcase with horizontal scrolling

### 📱 Additional Screens
- **Apps Screen** - All banking applications and services
- **Transaction Screen** - Transaction history with search and filter
- **Profile Screen** - User profile management and logout

### ⚡ Performance Features
- **Lazy Loading** - Content loads progressively for better performance
- **Loading Indicators** - Visual feedback during data loading
- **Smooth Animations** - Bouncing scroll physics and smooth transitions

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (3.0 or higher)
- [Dart SDK](https://dart.dev/get-dart) (3.0 or higher)
- Android Studio / VS Code with Flutter extensions
- iOS Simulator / Android Emulator / Physical Device

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/dashen_bank_app.git
cd dashen_bank_app
flutter pub get
flutter run
Configuration

Add assets to pubspec.yaml:
yaml

flutter:
  assets:
    - assets/logo.png

Project Structure
text

lib/
├── main.dart                 # Main application file
├── PinLoginScreen           # PIN authentication screen
├── DashenBankHomePage       # Main home screen with bottom navigation
├── HomeScreen               # Dashboard screen
├── AppsScreen               # Apps/services screen
├── TransactionScreen        # Transaction history screen
└── ProfileScreen            # User profile screen

🎨 UI/UX Features
Color Scheme

    Primary Color: #1A3E6F (Dashen Bank Blue)

    Secondary Color: #2C5282 (Darker Blue)

    Background: White

    Accent: Blue gradient effects

Typography

    System default font

    Responsive text sizing

    Bold headings for important information

Icons

    Material Icons for consistent design

    Custom icons for banking services

    Visual indicators for actions

🔒 Security Implementation

    PIN Protection: 5-digit PIN required for access

    Data Privacy: Sensitive information hidden by default

    Secure Navigation: Protected routes after authentication

    Session Management: Logout functionality to clear session

📱 Platform Support
Platform	Support
Android	✅ Full Support
iOS	✅ Full Support
Web	✅ Full Support
Desktop	⚠️ Limited Testing
🛠️ Built With

    Flutter - UI Framework

    Material Design - Design System

    Dart - Programming Language

📦 Dependencies
yaml

dependencies:
  flutter:
    sdk: flutter
  # No external dependencies required for core functionality

🚦 How to Use
PIN Login

    Launch the app

    Enter your 5-digit PIN

    Click the check button (✓) to login

    Wait for the loading animation (2 seconds)

Home Screen Features

    View Balance: Click the eye icon to show/hide balance

    Copy Account: Reveal account number, then click copy icon

    Quick Actions: Tap any service icon to access feature

    E-commerce: Scroll horizontally to view products

Navigation

    Use bottom navigation bar to switch between:

        Home

        Apps

        Transaction

        Profile

Logout

    Go to Profile screen

    Click "Logout" button

    Returns to PIN login screen

🎯 Future Enhancements

    Biometric authentication (Fingerprint/Face ID)

    Real API integration for transactions

    Push notifications

    QR code payments

    Bill payment integration

    Money transfer between accounts

    Transaction filters and date range

    Dark mode support

    Multi-language support

    Account statements (PDF export)

🤝 Contributing

    Fork the repository

    Create your feature branch (git checkout -b feature/AmazingFeature)

    Commit your changes (git commit -m 'Add some AmazingFeature')

    Push to the branch (git push origin feature/AmazingFeature)

    Open a Pull Request

📝 License

This project is for educational purposes only. All rights reserved.
⚠️ Disclaimer

This is a demonstration/educational project and is not affiliated with or endorsed by Dashen Bank. The app is created for learning purposes to showcase Flutter development capabilities.
👨‍💻 Developer

Seid Mohammed Seid

    GitHub: @seya2024

    Email: seidm2031@gmail.com

