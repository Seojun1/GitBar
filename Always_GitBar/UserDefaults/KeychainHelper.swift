// UserDefaults/KeychainHelper.swift

import Foundation
import Security

public class KeychainHelper {
    public static let shared = KeychainHelper()
    
    private let service = Bundle.main.bundleIdentifier ?? "Always_GitBar_Keychain"
    private let account = "github_access_token"
    
    private init() {
    }
    
    public func save(
        _ token: String
    ) -> Bool {
        guard let data = token.data(
            using: .utf8
        ) else {
            return false
        }
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
        ]
        SecItemDelete(
            query as CFDictionary
        )
        return SecItemAdd(
            query as CFDictionary,
            nil
        ) == errSecSuccess
    }
    
    public func read() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(
            query as CFDictionary,
            &dataTypeRef
        )
        if status == errSecSuccess, let data = dataTypeRef as? Data {
            return String(
                data: data,
                encoding: .utf8
            )
        }
        return nil
    }
    
    public func delete() -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        return SecItemDelete(
            query as CFDictionary
        ) == errSecSuccess
    }
}
