# Payram Wallet – iOS Assignment

This project is a basic Ethereum wallet generator built using **UIKit** and the open-source [TrustWalletCore SDK](https://github.com/trustwallet/wallet-core). It generates a new Ethereum wallet on first launch and securely stores the address and mnemonic in the **Keychain**. On subsequent launches, it retrieves and displays the wallet if it already exists.

Even though the Assessment Guide mentioned to integrate the **Gem Wallet SDK** , i couldn't find the required functionalities in any of their repos. I checked the [GemWalletCore](https://github.com/gemwalletcom/core.git) library and compiled it for Swift, but couldn't find the wallet generation functionality. Then i went through their open-source [iOS app](https://github.com/gemwalletcom/gem-ios) codebase and found they themselves use the TrustWalletCore library.

---

## 🚀 Setup Instructions

### Requirements
- Xcode 16.3
- Swift 5
- iOS 17.0+
- CocoaPods

### Steps

1. **Clone this repository**
   ```bash
   git clone https://github.com/yourusername/payram-wallet.git
   cd payram-wallet

2. **Install Dependencies**

Use Cocoapods to install WalletCore dependency.

```
pod install
```


3. **Build & Run**
Open the PayRam.xcworkspace file in Xcode. Build and run the app on a simulator or device

## Architecture & Design


### Design Pattern
This project uses Model-View-Controller (MVC): Even though it's an outdated pattern it was the easiest to get going and suitable for small projects like this.

#### Model:

*WalletManager*: Singleton for wallet generation and retrieval

*KeychainService*: Secure data storage helper

#### View:

*WalletCreatedViewController, HomeViewController*: Display wallet data

*Main Storyboard*  used for UI layout and transitions

#### Controller:

*LaunchViewController*: Handles logic to decide wallet creation vs reuse

I believe this simple structure is sufficient for the current scope and makes it easy to test and modify individual components.

*HomeViewController*: If wallet is already created and in secure storage, display the address

*WalletCreatedViewController*: If wallet is not created yet, allow user to generate wallet and display details as per requirement. Also displays error messages.






## How to Test the Wallet Creation Flow

 
Initial Launch (Clean State)

- *On first run* :
    
    - User is redirected to the Wallet Created screen showing:
        - Displays an interface that allows user to generate a new wallet
            - On wallet generation : Display the following
                - Full wallet address
                - First 3 words of the mnemonic phrase





- *Subsequent Launch* :

    - App detects the wallet exists in Keychain

    - User is redirected to the Home screen with the wallet address displayed

- *To Reset the Wallet* :

    - Uninstall the app to clear Keychain

    - Reinstall to test the full creation flow again
## Assumptions & Known Limitations

### Assumptions

- App only supports one Ethereum wallet per installation

- First 3 words of the mnemonic are shown to hint at successful generation, not for restoration

- Post re-installation, the user doesn't want to sync old Keychain data. This was discussed in the initial interview round and interpreted as a vulnerability. So old keychain values are invalidated without user confirmation.

### Limitations

- No backup/export mechanism for full mnemonic

- No biometric or PIN protection layer for access

- UI/UX is kept minimal due to time constraints

- Used Swift 5 because of familiarity.

### Possible Improvements

- Allow user to copy address to clipboard

- Encrypt mnemonic and wallet before saving to keychain. This adds an additional layer of security

- Perhaps only save the mnemonic and re-genrate wallet address everytime from it. One less value in secure storage, hence less vulnerability

- Add full wallet backup with secure UI flow

- Improve UI feedback and animations

- Add biometric/PIN authentication before showing wallet

- Support multiple chains/wallets

- Add unit tests 

- Upgrade project to latest Swift version

- Add app icons
## Challenges Faced

### Software updation

Mac OS version was outdated and some of my other software environements had some dependencies. Eventually everything was backed up and had to update Mac OS and Xcode. This delayed initial progress

### 3rd Party SDK Integration

*Gem Wallet SDK lacked wallet generation features despite assessment guidelines*

*Verified the GemWalletCore and their iOS app repos*

*Pivoted to TrustWalletCore after confirming its adoption in Gem's iOS app implementation*
