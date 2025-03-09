import Foundation
import KeychainSwift

class SecureDataStore {
    private let keychain = KeychainSwift(keyPrefix: "com.ondokuzon.apppricing_")
    private let deviceIDKey = "DeviceID"
    
    func getDeviceID() -> String {
        if let storedDeviceID = keychain.get(deviceIDKey) {
            return storedDeviceID
        } else {
            let randomGeneratedID = UUID().uuidString
            keychain.set(randomGeneratedID, forKey: deviceIDKey)
            return randomGeneratedID
        }
    }
}
