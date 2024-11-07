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
        var usage: Usage
    }

    enum Usage: String {
        case allCharacters = "Characters"
        case kara
        case akatsuki
        case tailedBeasts = "tailed beasts"
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
                    (state.characters.count < state.totalCharacters || state.page == 1) && !state.isLoading
                else { return .none}

                let usage = state.usage
                state.isLoading = true
                return .run { [page = state.page] send in
                    try await send(.characterListResponse(fetchCharacters(for: usage, page: page, perPage: perPage)))
                }

            case let .characterListResponse(result):
                state.totalCharacters = result.totalResults
                state.page += 1
                state.characters.append(contentsOf: mapCharacters(result, for: state.usage))
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

    private func fetchCharacters(for usage: Usage, page: Int, perPage: Int) async throws -> CharacterPagedModel {
        switch usage {
        case .allCharacters:
            return try await characterClient.fetchCharacters(page, perPage)

        case .kara:
            return try await characterClient.fetchKara(page, perPage)

        case .akatsuki:
            return try await characterClient.fetchAkatsuki(page, perPage)

        case .tailedBeasts:
            return try await characterClient.fetchTailedBeasts(page, perPage)
        }
    }

    private func mapCharacters(_ response: CharacterPagedModel, for usage: Usage) -> [CharacterModel] {
        switch usage {
        case .allCharacters:
            return response.characters ?? []

        case .kara:
            return response.kara ?? []

        case .akatsuki:
            return response.akatsuki ?? []

        case .tailedBeasts:
            return response.tailedBeasts ?? []
        }
    }
}

extension CharacterListReducer {

    @Reducer(state: .equatable)
    enum Destination {
        case characterDetail(CharacterDetailReducer)
    }
}
