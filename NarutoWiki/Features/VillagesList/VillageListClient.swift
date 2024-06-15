import ComposableArchitecture

struct VillageListClient {
    var fetchVillages: (Int, Int) async throws -> VillageListDTO
}

extension VillageListClient: DependencyKey {
    static var liveValue = Self { page, pageSize in
        let endpoint = NarutoAPI.villageListGET(page: page, pageSize: pageSize)
        return try await networkingProvider.sendRequest(endpoint: endpoint, responseModel: VillageListDTO.self)
    }
}

extension DependencyValues {
    var villageClient: VillageListClient {
        get { self[VillageListClient.self] }
        set { self[VillageListClient.self] = newValue }
    }
}
