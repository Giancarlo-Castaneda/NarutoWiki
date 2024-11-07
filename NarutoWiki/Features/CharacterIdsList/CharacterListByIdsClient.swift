import ComposableArchitecture

struct CharacterListByIdsClient {
    var fetchCharacterList: ([Int]) async throws -> [CharacterModel]
}

extension CharacterListByIdsClient: DependencyKey {
    static var liveValue = Self(
        fetchCharacterList: { ids in
            let endpoint = NarutoAPI.characterListGET(byIds: ids)

            let dto = try await networkingProvider.sendRequest(endpoint: endpoint, responseModel: SingleOrArray<CharacterDTO>.self)

            switch dto {
            case let .single(dto):
                return [CharacterModel(dto)]

            case let .array(dto):
                return dto.map { CharacterModel($0) }
            }


        }
    )
}

extension DependencyValues {
    var characterListByIdsClient: CharacterListByIdsClient {
        get { self[CharacterListByIdsClient.self] }
        set { self[CharacterListByIdsClient.self] = newValue }
    }
}
