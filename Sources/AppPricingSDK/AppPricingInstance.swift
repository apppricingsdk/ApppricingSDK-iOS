import Foundation

public class AppPricingInstance {
    nonisolated(unsafe) private static var appPricing: AppPricing?
    
    nonisolated(unsafe) private static var errorCallback: ErrorCallback?
    nonisolated(unsafe) private static var logCallback: LogCallback?
    
    public class func initialize(apiKey: String,
                                 isDebug: Bool = false,
                                 errorCallback: ErrorCallback? = nil,
                                 logCallback: LogCallback? = nil) {
        guard appPricing == nil else { return }
        
        self.appPricing = AppPricing(apiKey: apiKey)
        
        self.errorCallback = errorCallback
        self.logCallback = logCallback
    }

    public class func getDevicePlans() async throws -> [DevicePlan] {
        guard let appPricing else {
            raiseInitializationException()
        }
        
        do {
            let result = try await appPricing.postDeviceData()
            logCallback?(.info(message: "Device data posted successfully. Result: \(result.status)"))
        } catch {
            errorCallback?(error)
        }
        return try await appPricing.getDevicePlans()
    }
    
    public class func postPageRequest(pageName: String) {
        guard let appPricing else {
            raiseInitializationException()
        }
        
        Task {
            do {
                let result = try await appPricing.postPageRequest(pageName: pageName)
                logCallback?(.info(message: "Page request posted successfully. Result: \(result.status)"))
            } catch {
                errorCallback?(error)
            }
        }
    }
}

private extension AppPricingInstance {
     static func raiseInitializationException() -> Never {
        let reason = """
        AppPricingInstance has not been initialized properly. \
        Did you call `AppPricingInstance.initialize` already?
        """
        
        fatalError(reason)
    }
}
