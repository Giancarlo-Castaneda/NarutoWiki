import Foundation

struct NarutoAPI: RequestType {

    // MARK: - Internal Properties

    let path: String
    let method: HTTPMethod
    let body: [String: Any]?
    var queryItems: [URLQueryItem]?

    // MARK: - Initialization

    init(path: String, method: HTTPMethod, body: [String: Any]?, queryItems: [URLQueryItem]? = nil) {
        self.path = path
        self.method = method
        self.body = body
        self.queryItems = queryItems
    }
}
