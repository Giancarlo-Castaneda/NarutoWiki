import Foundation

extension NarutoAPI {

    static func villageListGET(page: Int, pageSize: Int) -> NarutoAPI {
        let query = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "limit", value: "\(pageSize)")
        ]

        return .init(path: "/villages", method: .get, body: nil, queryItems: query)
    }
}
