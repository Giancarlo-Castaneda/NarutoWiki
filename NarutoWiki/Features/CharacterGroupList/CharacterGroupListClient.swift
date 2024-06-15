import ComposableArchitecture

struct CharacterGroupListClient {
    var fetchVillages: (Int, Int) async throws -> CharacterGroupPagedDTO
    var fetchClans: (Int, Int) async throws -> CharacterGroupPagedDTO
    var fetchTeams: (Int, Int) async throws -> CharacterGroupPagedDTO
    var fetchKekkeiGenkai: (Int, Int) async throws -> CharacterGroupPagedDTO
}

extension CharacterGroupListClient: DependencyKey {
    static var liveValue = Self(
        fetchVillages: { page, pageSize in
            let endpoint = NarutoAPI.villageListGET(page: page, pageSize: pageSize)
            return try await networkingProvider.sendRequest(endpoint: endpoint, responseModel: CharacterGroupPagedDTO.self)
        }, fetchClans: { page, pageSize in
            let endpoint = NarutoAPI.clanListGET(page: page, pageSize: pageSize)
            return try await networkingProvider.sendRequest(endpoint: endpoint, responseModel: CharacterGroupPagedDTO.self)
        }, fetchTeams: { page, pageSize in
            let endpoint = NarutoAPI.teamListGET(page: page, pageSize: pageSize)
            return try await networkingProvider.sendRequest(endpoint: endpoint, responseModel: CharacterGroupPagedDTO.self)
        }, fetchKekkeiGenkai: { page, pageSize in
            let endpoint = NarutoAPI.kekkeiGenkaiListGET(page: page, pageSize: pageSize)
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
