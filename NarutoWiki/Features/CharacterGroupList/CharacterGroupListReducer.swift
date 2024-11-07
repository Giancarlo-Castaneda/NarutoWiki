import ComposableArchitecture

@Reducer
struct CharacterGroupListReducer {

    private let pageSize: Int = 20

    @ObservableState
    struct State: Equatable {
        var totalVillages = 0
        var page: Int = 1
        var villages: [CharacterGroupDTO] = []
        var isLoading = false
        var expectedUsage: ExpectedUsage
        var subtitleDescription: String = ""
    }

    enum ExpectedUsage: String {
        case villages
        case clans
        case kekkeiGenkais = "kekkei Genkai"
        case teams
    }

    enum Action {
        case characterGroupTapped([Int], String)
        case fetchVillageList
        case characterGroupListResponse(CharacterGroupPagedDTO)
    }

    @Dependency(\.characterGroupClient) var characterGroupClient

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchVillageList:
                guard
                    (state.villages.count < state.totalVillages || state.page == 1) && !state.isLoading
                else {
                    return .none
                }

                let usage = state.expectedUsage
                state.isLoading = true
                return .run { [page = state.page] send in
                    try await send(.characterGroupListResponse(fetchInfo(page: page,
                                                                  pageSize: pageSize,
                                                                  forUsage: usage)))
                }

            case let .characterGroupListResponse(result):
                state.totalVillages = result.total
                state.page += 1
                state.villages.append(contentsOf: mapResult(result, forUsage: state.expectedUsage))
                state.isLoading = false
                state.subtitleDescription = subtitle(expectedUsage: state.expectedUsage)
                return .none

            case .characterGroupTapped:
                return .none
            }
        }
    }

    private func fetchInfo(page: Int, pageSize: Int, forUsage expectedUsage: ExpectedUsage) async throws -> CharacterGroupPagedDTO {
        switch expectedUsage {
        case .villages:
            return try await characterGroupClient.fetchVillages(page, pageSize)

        case .clans:
            return try await characterGroupClient.fetchClans(page, pageSize)

        case .kekkeiGenkais:
            return try await characterGroupClient.fetchKekkeiGenkai(page, pageSize)

        case .teams:
            return try await characterGroupClient.fetchTeams(page, pageSize)
        }
    }

    private func mapResult(_  result: CharacterGroupPagedDTO,
                           forUsage expectedUsage: ExpectedUsage) -> [CharacterGroupDTO] {

        switch expectedUsage {
        case .villages:
            return result.villages ?? []

        case .clans:
            return result.clans ?? []

        case .kekkeiGenkais:
            return result.kekkeiGenkai ?? []

        case .teams:
            return result.teams ?? []
        }
    }

    private func subtitle(expectedUsage: ExpectedUsage) -> String {
        switch expectedUsage {
        case .villages:
            return "Current shinobis:"

        case .clans,
             .teams:
            return "Members:"

        case .kekkeiGenkais:
            return "Users:"
        }
    }
}
