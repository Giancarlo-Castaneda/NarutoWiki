import Foundation

struct CharacterPagedModel {
    let characters: [CharacterModel]?
    let kara: [CharacterModel]?
    let currentPage: Int
    let totalResults: Int
}

extension CharacterPagedModel {

    init(_ dto: CharacterListDTO) {
        self.init(characters: dto.characters?.compactMap { CharacterModel($0) },
                  kara: dto.kara?.compactMap { CharacterModel($0) },
                  currentPage: dto.currentPage,
                  totalResults: dto.total)
    }
}
