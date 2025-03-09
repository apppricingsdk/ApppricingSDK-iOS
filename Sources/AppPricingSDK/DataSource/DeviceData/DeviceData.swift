import Foundation

struct DeviceData: Encodable {
    let deviceID: String
    
    // Device Hardware Info
    let manufacturer: String = "Apple"
    let brand: String = "Apple"
    let model: String
    let device: String
    let product: String = "Apple"
    let board: String = "n/a"
    let hardware: String = "Apple"
    
    // SDK Info
    let sdkVersion: String
    
    // OS Info
    let osVersion: String
    let buildID: String
    let buildTime: TimeInterval
    let fingerprint: String
    
    // Screen Info
    let screenWidth: Int
    let screenHeight: Int
    
    // App Info
    let appVersion: String
    let appBuildNumber: String
    let packageName: String
    let firstInstallTime: Int64?
    let lastUpdateTime: Int64?
    
    // Locale Info
    let language: String
    let country: String
    let timeZone: String
    
    // Memory Info
    let totalMemory: UInt64
    let availableMemory: UInt64
    
    // CPU Info
    let numberOfCores: Int
}
