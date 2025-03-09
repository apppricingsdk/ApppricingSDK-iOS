enum APIEndpoint {
    case pages
    case deviceData
    case devicePlans(deviceID: String)
    
    var path: String {
        switch self {
        case .pages:
            return "api/pages"
        case .deviceData:
            return "api/device-data"
        case let .devicePlans(deviceID):
            return "api/device-data/\(deviceID)/plans"
        }
    }
    
    var httpMethod: String {
        switch self {
        case .deviceData, .pages:
            return "POST"
        default:
            return "GET"
        }
    }
}
