import ComposableArchitecture
import SwiftUI

struct ContentMenuView: View {
    var store : StoreOf<ContentMenuReducer>

    var body: some View {
        VStack {
            if let titleImage = store.titleImage {
                AsyncLazyImageView(url: titleImage)
                    .frame(maxWidth: 300)
                    .padding(.bottom)
            }
            let item = GridItem(.flexible(minimum: 50, maximum: 400), spacing: 10)
            LazyVGrid(columns: Array(repeating: item, count: 2)) {
                ForEach(store.contents, id: \.id) { item in
                    VStack {
                        Text(item.title)
                            .padding(.top)
                            .padding(.horizontal, 10)
                        if let url = URL(string: item.image) {
                            AsyncLazyImageView(url: url)
                                .padding(10)
                        }
                    }
                    .roundedCornerFill(lineWidth: 1,
                                       borderColor: Color.brown.opacity(0.3),
                                       radius: 10, corners: [.allCorners])
                }
            }
            .padding(.horizontal, 10)
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
