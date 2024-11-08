import ComposableArchitecture
import SwiftUI

struct ContentMenuView: View {

    @Bindable var store: StoreOf<ContentMenuReducer>
    let columns: Int = 2

    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = (screenWidth - CGFloat((columns + 1) * 10)) / CGFloat(columns)

        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            ScrollView {
                ParallaxHeader(coordinateSpace: CoordinateSpace.local, defaultHeight: 130) {
                    if let titleImage = store.titleImage {
                        AsyncLazyImageView(url: titleImage)
                            .frame(maxWidth: 300)
                            .padding(.bottom)
                    }
                }
                LazyVGrid(
                    columns: Array(repeating: GridItem(.fixed(itemWidth), spacing: 10), count: columns),
                    spacing: 10
                ) {
                    ForEach(store.contents, id: \.id) { item in
                        NavigationLink(state: getDesiredDestination(id: item.id)) {
                            VStack {
                                Text(item.title)
                                    .foregroundStyle(Color.primary)
                                    .padding(.top)
                                    .padding(.horizontal, 10)
                                if let url = URL(string: item.image) {
                                    AsyncLazyImageView(url: url)
                                        .frame(width: itemWidth - 20, height: itemWidth * 0.6)
                                        .padding(10)
                                }
                            }
                            .roundedCornerFill(borderColor: Color.brown.opacity(0.3),
                                               radius: 10, corners: [.allCorners])
                            .roundedCornerFill(borderColor: .white,
                                               radius: 10, corners: [.allCorners])
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .coordinateSpace(name: CoordinateSpace.local)
        } destination: { store in
            switch store.case {
            case let .characterList(store):
                CharacterListView(store: store)

            case let .villageList(store):
                CharacterGroupListView(store: store)

            case let .characterListIds(store):
                CharacterListIdsView(store: store)
            }
        }
        .onAppear {
            store.send(.fetchContent)
        }
    }

    func getDesiredDestination(id: Int) -> ContentMenuReducer.Destination.State? {
        switch id {
        case 1:
            return .characterList(CharacterListReducer.State(usage: .allCharacters))
        case 2:
            return .villageList(CharacterGroupListReducer.State(expectedUsage: .villages))
        case 3:
            return .villageList(CharacterGroupListReducer.State(expectedUsage: .clans))
        case 4:
            return .villageList(CharacterGroupListReducer.State(expectedUsage: .teams))
        case 5:
            return .villageList(CharacterGroupListReducer.State(expectedUsage: .kekkeiGenkais))
        case 6:
            return .characterList(CharacterListReducer.State(usage: .kara))
        case 7:
            return .characterList(CharacterListReducer.State(usage: .akatsuki))
        case 8:
            return .characterList(CharacterListReducer.State(usage: .tailedBeasts))
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
