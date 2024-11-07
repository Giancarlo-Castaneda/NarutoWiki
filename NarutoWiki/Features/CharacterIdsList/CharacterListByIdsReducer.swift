import ComposableArchitecture

@Reducer
struct CharacterListByIdsReducer {

    @ObservableState
    struct State {
        var ids: [Int]
        var title: String = ""
        var path = StackState<Destination.State>()
        var characters: [CharacterModel] = []
        var isLoading = false
    }

    enum Action {
        case fetchCharacters
        case characterListResponse([CharacterModel])
        case path(StackActionOf<Destination>)
    }

    @Reducer(state: .equatable)
    enum Destination {
        case characteDetail(CharacterDetailReducer)
    }

    @Dependency(\.characterListByIdsClient) var characterClient

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchCharacters:
                state.isLoading = true
                return .run { [ids = state.ids] send in
                    try await send(.characterListResponse(self.characterClient.fetchCharacterList(ids)))
                }

            case let .characterListResponse(result):
                state.characters = result
                state.isLoading = false
                return .none

            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}
