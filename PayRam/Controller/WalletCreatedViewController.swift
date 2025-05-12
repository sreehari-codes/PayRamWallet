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

    var walletAddress: String?
    var mnemonic: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Wallet creation View Controller launched")
        addressLabel.text = walletAddress

        if let words = mnemonic?.components(separatedBy: " "), words.count >= 3 {
            mnemonicLabel.text = words.prefix(3).joined(separator: " ") + "..."
        } else {
            mnemonicLabel.text = "Invalid mnemonic"
        }
    }
}
