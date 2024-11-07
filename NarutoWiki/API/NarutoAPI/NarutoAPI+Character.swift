import Foundation

extension NarutoAPI {

    static func characterListGET(page: Int, resultsPerPage: Int) -> NarutoAPI {
        let queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "limit", value: "\(resultsPerPage)")
        ]

        return .init(path: "/characters", method: .get, body: nil, queryItems: queryItems)
    }

    static func characterListGET(byIds ids: [Int]) -> NarutoAPI {
        let idsParam = ids.map { "\($0)" }.joined(separator: ",")

        return .init(path: "/characters/\(idsParam)", method: .get, body: nil)
    }

    static func karaListGET(page: Int, limit pageSize: Int) -> NarutoAPI {
        let query = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "limit", value: "\(pageSize)")
        ]

        return .init(path: "/kara", method: .get, body: nil, queryItems: query)
    }

    static func akatsukiListGET(page: Int, limit pageSize: Int) -> NarutoAPI {
        let query = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "limit", value: "\(pageSize)")
        ]

        return .init(path: "/akatsuki", method: .get, body: nil, queryItems: query)
    }
}
