import ComposableArchitecture

struct CharacterGroupListClient {
    var fetchVillages: (Int, Int) async throws -> CharacterGroupPagedDTO
    var fetchClans: (Int, Int) async throws -> CharacterGroupPagedDTO
}

extension CharacterGroupListClient: DependencyKey {
    static var liveValue = Self(
        fetchVillages: { page, pageSize in
            let endpoint = NarutoAPI.villageListGET(page: page, pageSize: pageSize)
            return try await networkingProvider.sendRequest(endpoint: endpoint, responseModel: CharacterGroupPagedDTO.self)
        }, fetchClans: { page, pageSize in
            let endpoint = NarutoAPI.clansListGET(page: page, pageSize: pageSize)
            return try await networkingProvider.sendRequest(endpoint: endpoint, responseModel: CharacterGroupPagedDTO.self)
        }
    )
}

extension DependencyValues {
    var characterGroupClient: CharacterGroupListClient {
        get { self[CharacterGroupListClient.self] }
        set { self[CharacterGroupListClient.self] = newValue }
    }
}
