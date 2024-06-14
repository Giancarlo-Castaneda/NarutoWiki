import ComposableArchitecture

@Reducer
struct CharacterListReducer {

    private let perPage: Int = 20

    @ObservableState
    struct State: Equatable {
        @Presents var destination: Destination.State?
        var totalCharacters = 0
        var page: Int = 1
        var characters: [CharacterModel] = []
        var isLoading = false
    }

    enum Action {
        case fetchCharacterList
        case characterListResponse(CharacterPagedModel)
        case detailTapped(CharacterModel)
        case destination(PresentationAction<Destination.Action>)
    }

    @Dependency(\.characterClient) var characterClient

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchCharacterList:
                guard
                    (perPage * state.page < state.totalCharacters || state.page == 1) && !state.isLoading
                else { return .none}

                state.isLoading = true
                return .run { [page = state.page] send in
                    try await send(.characterListResponse(self.characterClient.fetchCharacters(page, perPage)))
                }

            case let .characterListResponse(result):
                state.totalCharacters = result.totalResults
                state.page += 1
                state.characters.append(contentsOf: result.characters)
                state.isLoading = false
                return .none

            case let .detailTapped(character):
                state.destination = .characterDetail(
                    CharacterDetailReducer.State(detail: character)
                )
                return .none

            case .destination:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}

extension CharacterListReducer {

    @Reducer(state: .equatable)
    enum Destination {
        case characterDetail(CharacterDetailReducer)
    }
}
