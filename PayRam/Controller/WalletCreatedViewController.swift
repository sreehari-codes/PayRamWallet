//
//  WalletCreatedViewController.swift
//  PayRam
//
//  Created by Sreehari S on 12/05/25.
//

import Foundation
import UIKit

class WalletCreatedViewController: UIViewController {
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mnemonicLabel: UILabel!
    @IBOutlet weak var lblNoWalletTitle: UILabel!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var lblMnemonicTitle: UILabel!
    @IBOutlet weak var lblAddressTitle: UILabel!
    
    var walletAddress: String?
    var mnemonic: String?

    
    @IBAction func generateWallet(_ sender: Any) {
        
        WalletManager.shared.createWallet { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let wallet):
                    walletAddress = wallet.address
                    mnemonic = wallet.mnemonic
                    addressLabel.text = walletAddress

                    if let words = mnemonic?.components(separatedBy: " "), words.count >= 3 {
                        mnemonicLabel.text = words.prefix(3).joined(separator: " ") + "..."
                    } else {
                        mnemonicLabel.text = "Invalid mnemonic"
                    }
                    addressLabel.isHidden = false
                    mnemonicLabel.isHidden = false
                    lblAddressTitle.isHidden = false
                    lblMnemonicTitle.isHidden = false
                    generateButton.isHidden = true
                    lblNoWalletTitle.isHidden = true
                
//                    self.performSegue(withIdentifier: "showWalletCreated", sender: (wallet.address, wallet.mnemonic))
                    
                case .failure(let error):
                    self.showAlert(title: "Error", message: error.localizedDescription)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "PayRam"
        navigationItem.hidesBackButton = true
        print("Wallet creation View Controller launched")
        
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
