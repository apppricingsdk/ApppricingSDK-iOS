class AppPricing {
    private let apiProvider: APIProvider
    private let secureDataStore = SecureDataStore()
    
    init(apiKey: String) {
        self.apiProvider = APIProvider(apiKey: apiKey)
    }
    
    func postDeviceData() async throws {
        let deviceID = secureDataStore.getDeviceID()
        let deviceData = await DeviceDataCollector.collect(deviceID: deviceID)
        let deviceDataResponse = try await apiProvider.postDeviceData(deviceData)
    }
    
    func postPageRequest(pageName: String) async throws {
        let deviceID = secureDataStore.getDeviceID()
        try await apiProvider.postPagesRequest(deviceID: deviceID, pageName: pageName)
    }
    
    func getDevicePlans() async throws -> [DevicePlan] {
        let deviceID = secureDataStore.getDeviceID()
        return try await apiProvider.getDevicePlans(deviceID: deviceID).plans
    }
}
