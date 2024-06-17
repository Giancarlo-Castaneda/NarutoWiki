import ComposableArchitecture

@Reducer
struct CharacterDetailReducer {
    
    @ObservableState
    struct State: Equatable {
        var detail: CharacterModel
    }

    enum Action {
        case setDetail(CharacterModel)
        case closeDetailButton
    }

    @Dependency(\.dismiss) var dismiss

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .setDetail(character):
                state.detail = character
                return .none

            case .closeDetailButton:
                return .run { _ in await self.dismiss() }
            }
        }
    }
}
