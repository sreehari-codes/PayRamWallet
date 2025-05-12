//
//  HomeViewController.swift
//  PayRam
//
//  Created by Sreehari S on 12/05/25.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var addressLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "PayRam"
        print("Home View controller launched")
        
        navigationItem.hidesBackButton = true
        addressLabel.text = WalletManager.shared.getWalletAddress() ?? "No wallet found"
        
    }
}
