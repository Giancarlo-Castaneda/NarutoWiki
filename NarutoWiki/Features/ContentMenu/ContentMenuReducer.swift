import ComposableArchitecture
import Foundation

@Reducer
struct ContentMenuReducer {

    @Reducer(state: .equatable)
    enum Destination {
        case characterList(CharacterListReducer)
        case villageList(CharacterGroupListReducer)
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
                    ContentItemModel(id: 2, title: "Villages", image: "https://animeipics.wordpress.com/wp-content/uploads/2013/08/6f484-fivegreatninjacountriesmap-animeipics.png"),
                    ContentItemModel(id: 3, title: "Clans", image: "https://qph.cf2.quoracdn.net/main-qimg-c9489a8c8ac8fb654deb3d495910200c-lq"),
                    ContentItemModel(id: 4, title: "Teams", image: "https://i.redd.it/which-design-of-each-naruto-team-7-is-member-is-your-v0-qr386ava85wa1.jpg?width=550&format=pjpg&auto=webp&s=d11e9a938248911d84b411ad6b91177a3c79e752")
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
