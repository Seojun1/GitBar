// Resource/ConfigLoader.swift

import Foundation

public struct ConfigLoader {
    public static func getValue(forKey key: String) -> String? {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path) as? [String: Any] else {
            print("Config.plist를 찾을 수 없음")
            return nil
        }
        return dict[key] as? String
    }
}
