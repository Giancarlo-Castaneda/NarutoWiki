import Foundation

struct CharacterPagedModel {
    let characters: [CharacterModel]
    let currentPage: Int
    let totalResults: Int
}

extension CharacterPagedModel {

    init(_ dto: CharacterListDTO) {
        self.init(characters: dto.characters.map { CharacterModel($0) },
                  currentPage: dto.currentPage,
                  totalResults: dto.total)
    }
}
