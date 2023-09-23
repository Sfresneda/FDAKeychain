//
//  KeychainManager.swift
//  JOCS
//
//  Created by Sergio Fresneda on 3/9/23.
//

import Foundation
import Security

/// Keychain manager protocol
public protocol FDAKeychainManagerProtocol {
    /// Save data in keychain
    /// - Parameters:
    ///   - data: Data to save in keychain
    ///   - key: Key to save data
    ///   - type: Type of data to save
    /// - Returns: True if success
    func saveData(_ data: Data, for key: String, with type: CFString) -> Bool

    /// Load data from keychain
    /// - Parameters:
    ///  - key: Key to load data
    ///  - type: Type of data to load
    /// - Returns: Data if success or nil
    func loadData(for key: String, with type: CFString) -> Data?

    /// Delete data from keychain
    /// - Parameters:
    /// - key: Key to delete data
    /// - type: Type of data to delete
    /// - Returns: True if success or false
    func deleteData(for key: String, with type: CFString) -> Bool
}

/// Keychain manager
public final class FDAKeychainManager {
    public init() {
        // Silent is golden
    }
}

// MARK: - KeychainManagerProtocol
extension FDAKeychainManager: FDAKeychainManagerProtocol {
    /// Save data in keychain
    /// - Parameters:
    ///   - data: Data to save
    ///   - key: Key to save data
    ///   - type: Type of data to save
    /// - Returns: True if success
    @discardableResult
    public func saveData(_ data: Data, for key: String, with type: CFString) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: type,
            kSecAttrAccount as String: key,
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
        ]

        // Delete any existing items
        SecItemDelete(query as CFDictionary)

        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }

    /// Load data from keychain
    /// - Parameters:
    /// - key: Key to load data
    /// - type: Type of data to load
    /// - Returns: Data if success or nil
    public func loadData(for key: String, with type: CFString) -> Data? {
        let query = [
            kSecClass as String: type,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ] as [String: Any]

        var dataTypeRef: AnyObject? = nil
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        if status == errSecSuccess {
            let retrievedData = dataTypeRef as! Data
            return retrievedData
        } else {
            return nil
        }
    }

    /// Delete data from keychain
    /// - Parameters:
    /// - key: Key to delete data
    /// - type: Type of data to delete
    /// - Returns: True if success or false
    @discardableResult
    public func deleteData(for key: String, with type: CFString) -> Bool {
        let query = [
            kSecClass as String: type,
            kSecAttrAccount as String: key
        ] as [String: Any]

        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
}
