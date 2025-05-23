//
//  LaunchViewController.swift
//  PayRam
//
//  Created by Sreehari S on 12/05/25.
//

import Foundation
import UIKit

class LaunchViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Launch View Controller launched")
        navigationItem.title = "PayRam"
        let isFirstLaunch = UserDefaults.standard.bool(forKey: "hasLaunchedBefore")
        if !isFirstLaunch {
            // App is being launched for the first time
            UserDefaults.standard.setValue(true, forKey: "hasLaunchedBefore")
            UserDefaults.standard.synchronize()
            WalletManager.shared.overwriteSecureWalletDetails()
        }
        
        if WalletManager.shared.walletExists() {
            print("Navigating to Home")
            performSegue(withIdentifier: "showHome", sender: self)
        } else {
            performSegue(withIdentifier: "showWalletCreated", sender: self)
//            WalletManager.shared.createWallet { result in
//                DispatchQueue.main.async {
//                    switch result {
//                    case .success(let wallet):
//                        self.performSegue(withIdentifier: "showWalletCreated", sender: (wallet.address, wallet.mnemonic))
//                    case .failure(let error):
//                        self.showAlert(title: "Error", message: error.localizedDescription)
//                    }
//                }
//            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWalletCreated",
           let destination = segue.destination as? WalletCreatedViewController,
           let (address, mnemonic) = sender as? (String, String) {
            destination.walletAddress = address
            destination.mnemonic = mnemonic
        }
    }

    
}
