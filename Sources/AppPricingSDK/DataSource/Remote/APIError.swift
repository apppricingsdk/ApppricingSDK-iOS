import Foundation

enum APIError: LocalizedError {
    case invalidData
    case invalidResponse
    
    case invalidStatusCode(statusCode: Int)
    
    case decoding(error: Error)
    case custom(error: Error)
}
