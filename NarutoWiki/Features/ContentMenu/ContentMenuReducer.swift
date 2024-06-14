import ComposableArchitecture
import Foundation

@Reducer
struct ContentMenuReducer {

    @Reducer(state: .equatable)
    enum Destination {
        case characterList(CharacterListReducer)
    }

    @ObservableState
    struct State: Equatable {
        var path = StackState<Destination.State>()
        var contents: [ContentItemModel] = []
        var isLoading = false
        var titleImage: URL?
    }

    enum Action {
        case fetchContent
        case contentResponse([ContentItemModel])
        case path(StackActionOf<Destination>)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchContent:
                let contents = [
                    ContentItemModel(id: 1, title: "Characters", image: "https://wallpapers.com/images/featured/naruto-characters-peo1d7c1aqugno3e.jpg"),
                    ContentItemModel(id: 2, title: "Villages", image: "https://animeipics.wordpress.com/wp-content/uploads/2013/08/6f484-fivegreatninjacountriesmap-animeipics.png")
                ]
                state.isLoading = true
                return .run { send in
                    await send(.contentResponse(contents))
                }

            case let .contentResponse(result):
                state.titleImage = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c9/Naruto_logo.svg/400px-Naruto_logo.svg.png")!
                state.contents = result
                state.isLoading = false
                return .none

            case .path(_):
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}

struct ContentItemModel: Equatable {
    let id: Int
    let title: String
    let image: String
}
