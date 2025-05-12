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
    
    /**
     Overwrite secure wallet details in the keychain
     */
    func overwriteSecureWalletDetails() {
        keychain.set(value: "", for: walletKey)
        keychain.set(value: "", for: mnemonicKey)
    }

    /**
     Check whether wallet details already exists in the keychain
     */
    func walletExists() -> Bool {
        let w_key = keychain.get(key: walletKey) != nil && keychain.get(key: walletKey) != ""
        let m_key = keychain.get(key: mnemonicKey) != nil && keychain.get(key: mnemonicKey) != ""
        print("Wallet exists : \(w_key && m_key)")
        return w_key && m_key
//        return keychain.get(key: walletKey) != nil && keychain.get(key: mnemonicKey) != nil
    }

    /**
     Retrieve the wallet address from the keychain
     */
    func getWalletAddress() -> String? {
//        print("Gemstone lib version : \(Gemstone.libVersion())")
        return keychain.get(key: walletKey)
    }

    func createWallet(completion: @escaping (Result<(address: String, mnemonic: String), Error>) -> Void) {
        
        do {
            
            let wallet = HDWallet(strength: 128, passphrase: "")
            guard let address = wallet?.getAddressForCoin(coin: CoinType.ethereum) else {
                throw NSError(domain: "WalletError", code: 100, userInfo: [NSLocalizedDescriptionKey: "Wallet generation failed"])
            }
            guard let mnemonic = wallet?.mnemonic else {
                throw NSError(domain: "WalletError", code: 100, userInfo: [NSLocalizedDescriptionKey: "Mnemonic generation failed"])
            }
            
            // Store securely
            //TODO: Ideally should also encrypt the address and mnemonic before saving to keychain
            keychain.set(value: address, for: walletKey)
            keychain.set(value: mnemonic, for: mnemonicKey)
            completion(.success((address, mnemonic)))
        } catch {
            completion(.failure(error))
        }
         
    }

    /**
     Retrieve mnemonic of generated wallet from keychain
     */
    func getMnemonic() -> String? {
        return keychain.get(key: mnemonicKey)
    }
}
