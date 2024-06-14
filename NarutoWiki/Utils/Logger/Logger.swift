import Foundation

struct Logger {

    static func logRequest(_ request: URLRequest, with parameters: RequestType) {
        #if DEBUG
        let title = "📤 \(Date()) -> [\(request.httpMethod?.uppercased() ?? "")] " + (request.url?.absoluteString ?? "")
        let param = parameters.body ?? [:]
        print(title, "\nParameters:\n\(param.prettyPrintedJSONString ?? "")")
        #endif
    }

    static func logResponse(_ response: HTTPURLResponse, from request: URLRequest, data: Data) {
        #if DEBUG
        var logMessage = "⬇️ Response [\(response.statusCode)] - [\(request.httpMethod?.uppercased() ?? "")] "
        logMessage += (response.url?.absoluteString ?? "") + "\n\(data.prettyPrintedJSONString ?? "")"
        print(logMessage)
        #endif
    }
}
