import Foundation

struct VillageListDTO: Codable, Equatable {
    let villages: [VillageDTO]
    let currentPage, pageSize, total: Int
}

struct VillageDTO: Codable, Equatable {
    let id: Int
    let name: String
    let characters: [Int]
}
