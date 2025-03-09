import Foundation

public class AppPricingInstance {
    nonisolated(unsafe) private static var appPricing: AppPricing?
    
    public class func initialize(apiKey: String,
                                 isDebug: Bool = false,
                                 errorCallback: ErrorCallback? = nil,
                                 logCallback: LogCallback? = nil) {
        guard appPricing == nil else { return }
        self.appPricing = AppPricing(apiKey: apiKey)
    }

    public class func getDevicePlans() async throws -> [DevicePlan] {
        guard let appPricing else {
            raiseInitializationException()
        }
        try await appPricing.postDeviceData()
        return try await appPricing.getDevicePlans()
    }
    
    public class func postPageRequest(pageName: String) async throws {
        guard let appPricing else {
            raiseInitializationException()
        }
        try await appPricing.postPageRequest(pageName: pageName)
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
