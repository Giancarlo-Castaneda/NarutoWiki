import ComposableArchitecture
import SwiftUI

struct ContentMenuView: View {
    @Bindable var store : StoreOf<ContentMenuReducer>

    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            VStack {
                if let titleImage = store.titleImage {
                    AsyncLazyImageView(url: titleImage)
                        .frame(maxWidth: 300)
                        .padding(.bottom)
                }
                ScrollView {
                    let item = GridItem(.flexible(minimum: 50, maximum: 400), spacing: 10)
                    LazyVGrid(columns: Array(repeating: item, count: 2)) {
                        ForEach(store.contents, id: \.id) { item in
                            NavigationLink(state: getDesiredDestination(id: item.id)) {
                                VStack {
                                    Text(item.title)
                                        .foregroundStyle(Color.primary)
                                        .padding(.top)
                                        .padding(.horizontal, 10)
                                    if let url = URL(string: item.image) {
                                        AsyncLazyImageView(url: url)
                                            .padding(10)
                                    }
                                }
                                .roundedCornerFill(borderColor: Color.brown.opacity(0.3),
                                                   radius: 10, corners: [.allCorners])
                            }
                        }
                    }
                }
                .padding(.horizontal, 10)
            }
        } destination: { store in
            switch store.case {
            case let .characterList(store):
                CharacterListView(store: store)

            case let .villageList(store):
                CharacterGroupListView(store: store)
            }
        }
        .onAppear {
            store.send(.fetchContent)
        }
    }

    func getDesiredDestination(id: Int) -> ContentMenuReducer.Destination.State? {
        switch id {
        case 1:
            return ContentMenuReducer.Destination.State.characterList(CharacterListReducer.State())

        case 2:
            return ContentMenuReducer.Destination.State.villageList(CharacterGroupListReducer.State(expectedUsage: .villages))

        case 3:
            return ContentMenuReducer.Destination.State.villageList(CharacterGroupListReducer.State(expectedUsage: .clans))

        default:
            return nil
        }
    }
}

#Preview {
    ContentMenuView(store: Store(initialState: ContentMenuReducer.State(
        contents: [
            ContentItemModel(id: 1, title: "Characters", image: "https://wallpapers.com/images/featured/naruto-characters-peo1d7c1aqugno3e.jpg"),
            ContentItemModel(id: 2, title: "Villages", image: "https://animeipics.wordpress.com/wp-content/uploads/2013/08/6f484-fivegreatninjacountriesmap-animeipics.png")
        ], titleImage: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c9/Naruto_logo.svg/300px-Naruto_logo.svg.png")!
    )) {
        ContentMenuReducer()
    })
}
