import Foundation

// MARK: - CharacterListResponse
struct CharacterListDTO: Codable {
    let characters: [CharacterDTO]
    let currentPage, pageSize, total: Int
}

// MARK: - Character
struct CharacterDTO: Codable {
    let id: Int
    let name: String
    let images: [String]
    let debut: Debut?
    let family: Family?
    let jutsu: [String]?
    let natureType: [String]?
    let personal: VariablePersonal?
    let rank: VariableRank?
    let tools: [String]?
    let voiceActors: VoiceActors?
    let uniqueTraits: [String]?
}

enum VariableRank: Codable, Equatable {
    case rank(Rank?)
    case stringArray([String])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([String].self) {
            self = .stringArray(x)
            return
        }
        if let x = try? container.decode(Rank.self) {
            self = .rank(x)
            return
        }
        throw DecodingError.typeMismatch(VariableRank.self,
                                         DecodingError.Context(codingPath: decoder.codingPath,
                                                               debugDescription: "Wrong type for VariableRank")
        )
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .rank(let x):
            try container.encode(x)
        case .stringArray(let x):
            try container.encode(x)
        }
    }
}

enum VariablePersonal: Codable, Equatable {
    case personal(Personal)
    case stringArray([String])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([String].self) {
            self = .stringArray(x)
            return
        }
        if let x = try? container.decode(Personal.self) {
            self = .personal(x)
            return
        }
        throw DecodingError.typeMismatch(VariablePersonal.self,
                                         DecodingError.Context(codingPath: decoder.codingPath,
                                                               debugDescription: "Wrong type for Personal")
        )
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .personal(let x):
            try container.encode(x)
        case .stringArray(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Debut
struct Debut: Codable {
    let ova, anime, game, manga, novel, movie: String?
    let appearsIn: String
}

// MARK: - Family
struct Family: Codable, Equatable {
    let father, father2, fosterFather, mother, mother2, son, son2, fosterSon, daughter, fiancee: String?
    let wife, wife2, spouse, husband, adoptiveSon, adoptiveNephew, adoptiveNiece, godfather, brother, brother2, olderBrother: String?
    let twinBrother: String?
    let cloneSon, familyGrandmother, sister, sibling, nephew: String?
    let uncle, uncle2, adoptiveMother, adoptiveFather, adoptiveSons, adoptiveBrother, adoptiveGrandson: String?
    let clone, alteredClone, godson, greatGrandfather, grandfather, grandfather2: String?
    let grandmother, grandNiece, grandNephew, adoptiveCousin, adoptiveUncle, cousin, geneticTemplateParent, cloneBrother: String?
    let pet, grandson, grandson2, granddaughter, granddaughter2, ancestor, adoptiveGrandfather, adoptiveGrandmother, adoptiveGranduncle, adoptiveAunt, granduncle: String?
    let aunt, firstCousinOnceRemoved, host, niece: String?
    let lover, lover2, creator, creations, creation, geneticTemplate, geneticSource: String?
    let youngerBrother, youngerBrother2, youngerCousin, depoweredForm, incarnationWithTheGodTree: String?
    let greatGreatGrandfather, greatGreatGranddaughter, greatGreatGrandson2, originalForm, vessel: String?

    enum CodingKeys: String, CodingKey {
        case father, mother, son, daughter, wife, husband, spouse, ancestor
        case son2 = "son "
        case fosterSon = "foster son"
        case wife2 = "wife "
        case mother2 = "mother "
        case father2 = "father "
        case fosterFather = "foster father"
        case sibling
        case vessel
        case fiancee = "fiancée"
        case greatGreatGrandfather = "great-great-grandfather"
        case greatGreatGranddaughter = "great-great-granddaughter"
        case greatGreatGrandson2 = "great-great-grandson "
        case twinBrother = "twin brother"
        case brother2 = "brother "
        case olderBrother = "older brother"
        case godfather, brother
        case youngerCousin = "younger cousin"
        case youngerBrother = "younger brother"
        case youngerBrother2 = "younger brother "
        case alteredClone = "altered clone"
        case cloneSon = "clone/son"
        case familyGrandmother = "grandmother "
        case sister, nephew, uncle
        case uncle2 = "uncle "
        case grandNiece = "grandniece"
        case grandNephew = "grandnephew"
        case adoptiveGrandson = "adoptive grandson"
        case adoptiveNephew = "adoptive nephew"
        case adoptiveNiece = "adoptive niece"
        case adoptiveUncle = "adoptive uncle"
        case adoptiveAunt = "adoptive aunt"
        case adoptiveCousin = "adoptive cousin"
        case adoptiveFather = "adoptive father"
        case adoptiveMother = "adoptive mother"
        case adoptiveSon = "adoptive son"
        case adoptiveSons = "adoptive sons"
        case adoptiveBrother = "adoptive brother"
        case adoptiveGrandfather = "adoptive grandfather"
        case adoptiveGrandmother = "adoptive grandmother"
        case adoptiveGranduncle = "adoptive granduncle"
        case clone, godson, creations, creation
        case greatGrandfather = "great-grandfather"
        case grandfather, grandmother, cousin
        case grandfather2 = "grandfather "
        case geneticTemplateParent = "genetic template/parent"
        case geneticSource = "genetic source"
        case cloneBrother = "clone/brother"
        case pet = "pet "
        case originalForm = "original form"
        case depoweredForm = "depowered form"
        case incarnationWithTheGodTree = "incarnation with the god tree"
        case grandson, granddaughter, granduncle, aunt
        case grandson2 = "grandson "
        case granddaughter2 = "granddaughter "
        case firstCousinOnceRemoved = "first cousin once removed"
        case host, niece, lover, creator
        case lover2 = "lover "
        case geneticTemplate = "genetic template"
    }
}

// MARK: - Personal
struct Personal: Codable, Equatable {
    let birthdate: String?
    let sex: Sex?
    let age: HistoryPeriod?
    let height: HistoryPeriod?
    let weight: HistoryPeriod?
    let bloodType: BloodType?
    let kekkeiGenkai, classification, kekkeiMōra, affiliation: Clan?
    let tailedBeast: String?
    let occupation: Clan?
    let team, clan: Clan?
    let titles: [String]?
    let status: String?
    let partner: Clan?
    let species: String?
}

// MARK: - Age
struct HistoryPeriod: Codable, Equatable {
    let partI, partII, academyGraduate, chuninPromotion, gaiden: String?
    let blankPeriod, borutoMovie, borutoManga: String?

    enum CodingKeys: String, CodingKey {
        case partI = "Part I"
        case partII = "Part II"
        case academyGraduate = "Academy Graduate"
        case chuninPromotion = "Chunin Promotion"
        case blankPeriod = "Blank Period"
        case gaiden = "Gaiden"
        case borutoMovie = "Boruto Movie"
        case borutoManga = "Boruto Manga"
    }
}

enum BloodType: String, Codable, Equatable {
    case a = "A"
    case ab = "AB"
    case b = "B"
    case o = "O"
}

enum Clan: Codable, Equatable {
    case string(String)
    case stringArray([String])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([String].self) {
            self = .stringArray(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Clan.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Clan"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let x):
            try container.encode(x)
        case .stringArray(let x):
            try container.encode(x)
        }
    }
}

enum Sex: String, Codable, UnknownCaseDecodable, Equatable {
    case female = "Female"
    case male = "Male"
    case unknown
}

public protocol UnknownCaseDecodable: Decodable where Self: RawRepresentable {
    static var unknown: Self { get }
}

extension UnknownCaseDecodable where RawValue: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(RawValue.self)
        self = .init(rawValue: rawValue) ?? Self.unknown
    }
}


// MARK: - Rank
struct Rank: Codable, Equatable {
    let ninjaRank: HistoryPeriod?
    let ninjaRegistration: String?
}

// MARK: - VoiceActors
struct VoiceActors: Codable {
    let japanese, english: Clan?
}
