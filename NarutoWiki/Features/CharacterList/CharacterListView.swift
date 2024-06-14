import ComposableArchitecture
import SwiftUI

struct CharacterListView: View {
    @Bindable var store: StoreOf<CharacterListReducer>

    var body: some View {
//        NavigationStack {
            GeometryReader { geometry in
                ScrollView {
                    let spacing: CGFloat = 10
                    let width = geometry.size.width / 2 - spacing
                    let side = width < 0 ? 200 : width
                    let item = GridItem(.flexible(minimum: 50, maximum: side), spacing: spacing)
                    LazyVGrid(columns:  Array(repeating: item, count: 2)) {
                        ForEach(store.characters, id: \.id) { character in
                            VStack {
                                if let image = character.images.first,
                                   let url = URL(string: image) {
                                    AsyncLazyImageView(url: url)
                                        .frame(maxHeight: side)
                                        .padding(5)
                                }
                                Text(character.name)
                                    .padding(.horizontal, 5)
                                    .padding(.bottom)
                            }
                            .frame(minWidth: side,  minHeight: side)
                            .roundedCornerFill(lineWidth: 1, borderColor: Color.brown.opacity(0.3), radius: 10, corners: [.allCorners])

                            .onTapGesture {
                                store.send(.detailTapped(character))
                            }
                        }
                        if store.isLoading {
                            ProgressView()
                        } else {
                            Color.clear
                                .onAppear {
                                    if !store.characters.isEmpty {
                                        store.send(.fetchCharacterList)
                                    }
                                }
                        }
                    }

                }
                .onAppear {
                    store.send(.fetchCharacterList)
                }
                .navigationTitle("Personajes")
            }
//        }
        .sheet(item: $store.scope(state: \.destination?.characterDetail,
                                  action: \.destination.characterDetail)
        ) { characterDetailStore in
            NavigationStack {
                CharacterDetailView(store: characterDetailStore)
            }
        }
    }
}

#Preview {
    CharacterListView(store: Store(initialState: CharacterListReducer.State()) {
        CharacterListReducer()
    })
}
