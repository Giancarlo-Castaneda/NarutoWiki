import Foundation

extension NarutoAPI {

    static func characterListGET(page: Int, resultsPerPage: Int) -> NarutoAPI {
        let queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "limit", value: "\(resultsPerPage)")
        ]

        return .init(path: "/characters", method: .get, body: nil, queryItems: queryItems)
    }
}
