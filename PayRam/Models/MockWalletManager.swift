//
//  MockWalletManager.swift
//  PayRam
//
//  Created by Sreehari S on 12/05/25.
//

import Foundation
//import Gemstone
//import GemstoneFFI

class MockWalletManager {
    static let shared = MockWalletManager()

    private let keychain = KeychainService()
    private let walletKey = "eth_wallet"
    private let mnemonicKey = "eth_mnemonic"

    private init() {}

    func walletExists() -> Bool {
        return keychain.get(key: walletKey) != nil && keychain.get(key: mnemonicKey) != nil
    }

    func getWalletAddress() -> String? {
//        print("Gemstone lib versionnnn : \(Gemstone.libVersion())")
        
//        print("Generated mnemonic : \(mnemonic)")
        return keychain.get(key: walletKey)
    }

    func createWallet(completion: @escaping (Result<(address: String, mnemonic: String), Error>) -> Void) {
        do {
//            let wallet = try Wallet() // Generates new Ethereum wallet
//            let address = wallet.address
//            guard let mnemonic = wallet.mnemonic else {
//                throw NSError(domain: "WalletError", code: 100, userInfo: [NSLocalizedDescriptionKey: "Mnemonic generation failed"])
//            }
            let address = "Hardcoded_eth_wallet_address"
            let mnemonic = "hello happy new"
            // Store securely
            keychain.set(value: address, for: walletKey)
            keychain.set(value: mnemonic, for: mnemonicKey)
            print("Created wallet and mnemonic")
            completion(.success((address, mnemonic)))
        } catch {
            completion(.failure(error))
        }
    }

    func getMnemonic() -> String? {
        return keychain.get(key: mnemonicKey)
    }
}
