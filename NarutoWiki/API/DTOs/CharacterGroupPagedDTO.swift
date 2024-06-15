import Foundation

struct CharacterGroupPagedDTO: Codable, Equatable {
    let villages: [CharacterGroupDTO]?
    let clans: [CharacterGroupDTO]?
    let kekkeiGenkai: [CharacterGroupDTO]?
    let teams: [CharacterGroupDTO]?
    let currentPage, pageSize, total: Int

    enum CodingKeys: String, CodingKey {
        case kekkeiGenkai = "kekkei-genkai"
        case currentPage, pageSize, total
        case villages
        case clans
        case teams
    }
}

struct CharacterGroupDTO: Codable, Equatable {
    let id: Int
    let name: String
    let characters: [Int]
}
