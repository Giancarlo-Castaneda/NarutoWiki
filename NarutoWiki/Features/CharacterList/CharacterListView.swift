import ComposableArchitecture
import SwiftUI

struct CharacterListView: View {
    @Bindable var store: StoreOf<CharacterListReducer>

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible(minimum: 100, maximum: 400))]) {
                    ForEach(store.characters, id: \.id) { character in
                        VStack {
                            if let image = character.images.first,
                               let url = URL(string: image) {
                                ImageView(withURL: url)
                                    .aspectRatio(1.3, contentMode: .fit)
                            }
                            Text(character.name)
                        }
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
