import ComposableArchitecture
import Foundation

struct CharacterListClient {
    var fetchCharacters: (Int, Int) async throws -> CharacterPagedModel
    var fetchKara: (Int, Int) async throws -> CharacterPagedModel
    var fetchAkatsuki: (Int, Int) async throws -> CharacterPagedModel
    var fetchTailedBeasts: (Int, Int) async throws -> CharacterPagedModel
}

extension CharacterListClient: DependencyKey {
    static let liveValue = Self (
        fetchCharacters: { page, limit in
            let endpoint = NarutoAPI.characterListGET(page: page, resultsPerPage: limit)
            let dto = try await networkingProvider.sendRequest(endpoint: endpoint, responseModel: CharacterListDTO.self)

            return CharacterPagedModel(dto)

        }, fetchKara: { page, limit in
            let endpoint = NarutoAPI.karaListGET(page: page, limit: limit)
            let dto = try await networkingProvider.sendRequest(endpoint: endpoint, responseModel: CharacterListDTO.self)

            return CharacterPagedModel(dto)

        }, fetchAkatsuki: { page, limit in
            let endpoint = NarutoAPI.akatsukiListGET(page: page, limit: limit)
            let dto = try await networkingProvider.sendRequest(endpoint: endpoint, responseModel: CharacterListDTO.self)

            return CharacterPagedModel(dto)

        }, fetchTailedBeasts: { page, limit in
            let endpoint = NarutoAPI.tailedBeastsListGET(page: page, limit: limit)
            let dto = try await networkingProvider.sendRequest(endpoint: endpoint, responseModel: CharacterListDTO.self)

            return CharacterPagedModel(dto)
        }
    )
}

extension DependencyValues {
    var characterClient: CharacterListClient {
        get { self[CharacterListClient.self] }
        set { self[CharacterListClient.self] = newValue }
    }
}

let jsonDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    let formatter = DateFormatter()
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    decoder.dateDecodingStrategy = .formatted(formatter)
    return decoder
}()

let networkingProvider: NetworkingProvider = {
    ConcreteNetworkingProvider(jsonDecoder: jsonDecoder)
}()
