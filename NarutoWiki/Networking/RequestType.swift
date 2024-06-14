import Foundation

public protocol RequestType {

    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var header: [String: String] { get }
    var body: [String: Any]? { get }
    var queryItems: [URLQueryItem]? { get }
}

public extension RequestType {

    var scheme: String {
        "https"
    }

    var host: String {
        "dattebayo-api.onrender.com"
    }

    var header: [String: String] {
        [:]
    }
}
