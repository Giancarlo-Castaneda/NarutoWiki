import ComposableArchitecture
import SwiftUI

struct CharacterListIdsView: View {
    let store: StoreOf<CharacterListByIdsReducer>

    var body: some View {
        ScrollView {
            let item = [GridItem(.flexible(minimum: 20, maximum: 400))]
            LazyVGrid(columns: item) {
                ForEach(store.characters, id: \.id) { character in
                    HStack(alignment: .center) {
                        if let image = character.images.first,
                           let url = URL(string: image) {
                            AsyncLazyImageView(url: url)
                                .frame(width: 100)
                                .padding(5)
                        }
                        Text(character.name)
                            .padding(.horizontal, 5)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .roundedCornerFill(borderColor: Color.yellow.opacity(0.3),
                                       radius: 10, corners: [.allCorners])
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle(store.state.title)
        .onAppear {
            store.send(.fetchCharacters)
        }
    }
}

#Preview {
    CharacterListIdsView(store: Store(initialState: CharacterListByIdsReducer.State(
        ids: [82,2],
        title: "foo.title"
    )) {
        CharacterListByIdsReducer()
    })
}
