import ComposableArchitecture
import SwiftUI

struct CharacterGroupListView: View {
    var store: StoreOf<CharacterGroupListReducer>

    var body: some View {
        ScrollView {
            let item = [GridItem(.flexible(minimum: 20, maximum: 400))]
            LazyVGrid(columns: item) {
                ForEach(store.villages, id: \.id) { village in
                    VStack {
                        Text(village.name)
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: Alignment.leading)
                        Text("\(store.subtitleDescription) \(village.characters.count)")
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: Alignment.leading)
                    }
                    .padding(10)
                    .roundedCornerFill(borderColor: Color.blue.opacity(0.3), radius: 10, corners: [.allCorners])
                }
                if store.isLoading {
                    ProgressView()
                } else {
                    Color.clear
                        .onAppear {
                            if !store.villages.isEmpty {
                                store.send(.fetchVillageList)
                            }
                        }
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle("Hidden Villages")
        .onAppear {
            store.send(.fetchVillageList)
        }
    }
}

#Preview {
    CharacterGroupListView(store: Store(initialState: CharacterGroupListReducer.State(expectedUsage: .villages)) {
        CharacterGroupListReducer()
    })
}
