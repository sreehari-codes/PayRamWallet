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

        if WalletManager.shared.walletExists() {
            print("Navigating to Home")
            performSegue(withIdentifier: "showHome", sender: self)
        } else {
            WalletManager.shared.createWallet { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let wallet):
                        self.performSegue(withIdentifier: "showWalletCreated", sender: (wallet.address, wallet.mnemonic))
                    case .failure(let error):
                        self.showAlert(title: "Error", message: error.localizedDescription)
                    }
                }
            }
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

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
