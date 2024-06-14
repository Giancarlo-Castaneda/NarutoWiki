import Foundation

struct CharacterModel: Equatable {
    let id: Int
    let name: String
    let images: [String]
    let jutsus: [String]
    let natureTypes: [String]?
    let tools: [String]?
    let uniqueTraits: [String]?
    let rank: VariableRank?
    let voiceActors: VoiceActorsModel?
    let personal: VariablePersonal?
    let family: Family?
}

extension CharacterModel {

    init(_ dto: CharacterDTO) {
        self.init(id: dto.id,
                  name: dto.name,
                  images: dto.images,
                  jutsus: dto.jutsu ?? [],
                  natureTypes: dto.natureType,
                  tools: dto.tools,
                  uniqueTraits: dto.uniqueTraits,
                  rank: dto.rank,
                  voiceActors: VoiceActorsModel(dto.voiceActors),
                  personal: dto.personal,
                  family: dto.family)
    }
}

extension CharacterModel {
    static let mock = CharacterModel(
        id: 111,
        name: "foo.name",
        images: [
            "https://static.wikia.nocookie.net/naruto/images/d/d6/Naruto_Part_I.png",
            "https://static.wikia.nocookie.net/naruto/images/7/7d/Naruto_Part_II.png"
        ],
        jutsus: ["foo.0.jutsu","foo.1.jutsu"],
        natureTypes: ["foo.0.nature","foo.1.nature"],
        tools: ["foo.0.tool","foo.1.tool"],
        uniqueTraits: ["foo.0.trait","foo.1.trait"], 
        rank: .rank(Rank(ninjaRank: .init(partI: "partI",
                                          partII: "partII",
                                          academyGraduate: "academyGraduate",
                                          chuninPromotion: "chuninPromotion",
                                          gaiden: "gaiden",
                                          blankPeriod: "blankPeriod",
                                          borutoMovie: "borutoMovie",
                                          borutoManga: "borutoManga"),
                         ninjaRegistration: "ninjaRegistration")),
        voiceActors: VoiceActorsModel(japaneseActors: .string("foo.japa"), englishActors: .stringArray(["foo.0.eng"])),
        personal: .stringArray(["foo.personal"]),
        family: nil
    )
}
