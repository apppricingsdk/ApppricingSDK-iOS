import UIKit

@MainActor class DeviceDataCollector {
    private init() {}
    
    static func collect(deviceID: String) -> DeviceData {
        let device = UIDevice.current
        let processInfo = ProcessInfo.processInfo
        let screenSize = UIScreen.main.bounds.size
        let locale = Locale.current
        
        let language = locale.language.languageCode?.identifier ?? "n/a"
        let country = locale.region?.identifier ?? "n/a"
        let timeZone = TimeZone.current.identifier
        
        let bundle = Bundle.main
        let appVersion = bundle.infoDictionary?["CFBundleShortVersionString"] as? String ?? "n/a"
        let buildNumber = bundle.infoDictionary?["CFBundleVersion"] as? String ?? "n/a"
        let packageName = bundle.bundleIdentifier ?? "n/a"
        
        // TODO
        let sdkVersion = "sdk_version"
        let systemVersion = device.systemVersion
        
        // TODO: Add session count
        
        let totalMemory = processInfo.physicalMemory
        let availableMemoryProc = os_proc_available_memory()
        let availableMemory = availableMemoryProc != 0 ? UInt64(availableMemoryProc) : totalMemory
        return DeviceData(deviceID: deviceID,
                          model: device.model,
                          device: device.name,
                          sdkVersion: sdkVersion,
                          osVersion: systemVersion,
                          buildID: buildNumber,
                          buildTime: processInfo.systemUptime,
                          fingerprint: "\(device.model) \(systemVersion)",
                          screenWidth: Int(screenSize.width),
                          screenHeight: Int(screenSize.height),
                          appVersion: appVersion,
                          appBuildNumber: buildNumber,
                          packageName: packageName,
                          firstInstallTime: getFirstInstallTimeInMilliseconds(),
                          lastUpdateTime: getLastUpdateTimeInMilliseconds(),
                          language: language,
                          country: country,
                          timeZone: timeZone,
                          totalMemory: processInfo.physicalMemory,
                          availableMemory: availableMemory,
                          numberOfCores: processInfo.processorCount)
    }
}

private extension DeviceDataCollector {
    static func getFirstInstallTimeInMilliseconds() -> Int64? {
        Int64(getFirstInstallDate()?.timeIntervalSince1970 ?? 0) * 1000
    }
    
    static func getLastUpdateTimeInMilliseconds() -> Int64? {
        Int64(getLastUpdateDate()?.timeIntervalSince1970 ?? 0) * 1000
    }
    
    static func getFirstInstallDate() -> Date? {
        guard let url = Bundle.main.url(forResource: "Info", withExtension: "plist") else { return nil }
        return (try? FileManager.default.attributesOfItem(atPath: url.path)[.creationDate]) as? Date
    }
    
    static func getLastUpdateDate() -> Date? {
        guard let url = Bundle.main.executableURL else { return nil }
        return (try? FileManager.default.attributesOfItem(atPath: url.path)[.modificationDate]) as? Date
    }
}
