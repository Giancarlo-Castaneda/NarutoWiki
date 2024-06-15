import ComposableArchitecture

@Reducer
struct VillageListReducer {

    private let pageSize: Int = 20

    @ObservableState
    struct State: Equatable {
        var totalVillages = 0
        var page: Int = 1
        var villages: [VillageDTO] = []
        var isLoading = false
    }

    enum Action {
        case fetchVillageList
        case villageListResponse(VillageListDTO)
    }

    @Dependency(\.villageClient) var villageClient

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchVillageList:
                guard
                    (state.villages.count < state.totalVillages || state.page == 1) && !state.isLoading
                else {
                    return .none
                }

                state.isLoading = true
                return .run { [page = state.page] send in
                    try await send(.villageListResponse(self.villageClient.fetchVillages(page, pageSize)))
                }

            case let .villageListResponse(result):
                state.totalVillages = result.total
                state.page += 1
                state.villages.append(contentsOf: result.villages)
                state.isLoading = false
                return .none
            }
        }
    }
}
