import Foundation

class APIProvider {
    private let urlSession = URLSession.shared
    private let baseURL = "https://dash.apppricing.com/"
    private let apiKey: String
    
    private lazy var jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
    
    private lazy var jsonEncoder: JSONEncoder = {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
        return jsonEncoder
    }()
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func postDeviceData(_ deviceData: DeviceData) async throws -> DeviceDataResponse {
        let urlRequest = try generateURLRequest(for: .deviceData, request: deviceData)
        return try await execute(urlRequest: urlRequest)
    }
    
    func postPagesRequest(deviceID: String, pageName: String) async throws -> PagesResponse {
        let pagesRequest = PagesRequest(deviceID: deviceID, pageName: pageName)
        let urlRequest = try generateURLRequest(for: .pages, request: pagesRequest)
        return try await execute(urlRequest: urlRequest)
    }
    
    func getDevicePlans(deviceID: String) async throws -> DevicePlansResponse {
        let urlRequest = try generateURLRequest(for: .devicePlans(deviceID: deviceID))
        return try await execute(urlRequest: urlRequest)
    }
}

private extension APIProvider {
    func execute<T: Decodable>(urlRequest: URLRequest) async throws(APIError) -> T {
        do {
            let (data, response) = try await urlSession.data(for: urlRequest)
            guard !data.isEmpty else {
                throw APIError.invalidData
            }
            guard let response = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            guard 200...301 ~= response.statusCode else {
                throw APIError.invalidStatusCode(statusCode: response.statusCode)
            }
            return try jsonDecoder.decode(T.self, from: data)
        } catch let error as APIError {
            throw error
        } catch let error as DecodingError {
            throw .decoding(error: error)
        } catch {
            throw .custom(error: error)
        }
    }
    
    func generateURLRequest(for endpoint: APIEndpoint, request: Encodable? = nil) throws -> URLRequest {
        guard let url = URL(string: baseURL)?.appending(path: endpoint.path) else {
            preconditionFailure("Could not construct endpoint for \(endpoint.path)")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.httpMethod
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        if let request {
            urlRequest.httpBody = try jsonEncoder.encode(request)
        }
        return urlRequest
    }
}
