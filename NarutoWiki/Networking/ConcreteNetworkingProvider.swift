import Foundation

final class ConcreteNetworkingProvider: NetworkingProvider {

    // MARK: - Private Properties

    private let jsonDecoder: JSONDecoder

    // MARK: - Initialization

    init(jsonDecoder: JSONDecoder) {
        self.jsonDecoder = jsonDecoder
    }

    // MARK: - Private Methods

    private func createURLComponents(endpoint: RequestType) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.queryItems

        return urlComponents
    }

    private func createRequest(endpoint: RequestType) throws -> URLRequest {
        guard
            let url = createURLComponents(endpoint: endpoint).url
        else { throw RequestError.invalidURL }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header

        if let body = endpoint.body {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        }

        return request
    }

    private func launchTask(request: URLRequest) async throws -> Data {
        do {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
            guard
                let response = response as? HTTPURLResponse
            else { throw RequestError.noResponse }

            Logger.logResponse(response, from: request, data: data)

            switch response.statusCode {
            case 200...299:
                return data

            case 400:
                throw RequestError.badRequest

            case 401:
                throw RequestError.unauthorized

            default:
                throw RequestError.unexpectedStatusCode
            }
        } catch {
            throw error
        }
    }

    // MARK: - Internal Methods

    func sendRequest(endpoint: RequestType) async throws {
        let request = try createRequest(endpoint: endpoint)

        _ = try await launchTask(request: request)
    }

    func sendRequest<T: Decodable>(endpoint: RequestType, responseModel: T.Type) async throws -> T {
        let request = try createRequest(endpoint: endpoint)
        Logger.logRequest(request, with: endpoint)
        let data = try await launchTask(request: request)

        do {
            let decodedResponse = try jsonDecoder.decode(responseModel, from: data)

            return decodedResponse
        } catch {
            throw error
        }
    }
}
