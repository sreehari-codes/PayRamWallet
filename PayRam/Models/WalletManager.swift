//
//  WalletManager.swift
//  PayRam
//
//  Created by Sreehari S on 12/05/25.
//


import Foundation
import WalletCore

class WalletManager {
    static let shared = WalletManager()

    private let keychain = KeychainService()
    private let walletKey = "eth_wallet"
    private let mnemonicKey = "eth_mnemonic"

    private init() {}

    func walletExists() -> Bool {
        return keychain.get(key: walletKey) != nil && keychain.get(key: mnemonicKey) != nil
    }

    func getWalletAddress() -> String? {
//        print("Gemstone lib version : \(Gemstone.libVersion())")
        let wallet = HDWallet(strength: 128, passphrase: "")
        let mnemonic = wallet?.mnemonic
        print("mnemonic : \(mnemonic ?? "")")
        return keychain.get(key: walletKey)
    }

    func createWallet(completion: @escaping (Result<(address: String, mnemonic: String), Error>) -> Void) {
        
        do {
           
            /*
            // Generate 24-word mnemonic
            let mnemonic = try await Gemstone.generateMnemonic(wordCount: 24)
            // Create Ethereum wallet
            let wallet = try await Gemstone.createWallet(
                blockchain: .ethereum,
                mnemonic: mnemonic,
                passphrase: "" // Optional passphrase
            )
            let address = wallet.address
            guard let mnemonic = wallet.mnemonic else {
                throw NSError(domain: "WalletError", code: 100, userInfo: [NSLocalizedDescriptionKey: "Mnemonic generation failed"])
            }
             */
            let address = "Hardcoded_eth_wallet_address"
            let mnemonic = "hello happy new"
            // Store securely
            keychain.set(value: address, for: walletKey)
            keychain.set(value: mnemonic, for: mnemonicKey)
            completion(.success((address, mnemonic)))
        } catch {
            completion(.failure(error))
        }
         
    }

    func getMnemonic() -> String? {
        return keychain.get(key: mnemonicKey)
    }
}
