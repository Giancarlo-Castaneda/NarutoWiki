import Foundation

struct RankModel: Equatable {
    let ninjaRank: NinjaRankModel?
    let ninjaRegistration: String?
}

extension RankModel {

    init?(_ dto: Rank?) {
        guard let dto else { return nil }
        self.init(ninjaRank: NinjaRankModel(dto.ninjaRank), ninjaRegistration: dto.ninjaRegistration)
    }
}

struct NinjaRankModel: Equatable {
    let partI: String?
    let partII: String?
    let academyGraduate: String?
    let chuninPromotion: String?
    let gaiden: String?
    let blankPeriod: String?
    let borutoMovie: String?
    let borutoManga: String?
}

extension NinjaRankModel {

    init?(_ dto: HistoryPeriod?) {
        guard let dto else { return nil }
        self.init(partI: dto.partI,
                  partII: dto.partII,
                  academyGraduate: dto.academyGraduate,
                  chuninPromotion: dto.chuninPromotion,
                  gaiden: dto.gaiden,
                  blankPeriod: dto.blankPeriod,
                  borutoMovie: dto.borutoMovie,
                  borutoManga: dto.borutoManga)
    }
}

struct VoiceActorsModel: Equatable {
    let japaneseActors, englishActors: Clan?
}

extension VoiceActorsModel {

    init?(_ dto: VoiceActors?) {
        guard let dto else { return nil }
        self.init(japaneseActors: dto.japanese, englishActors: dto.english)
    }
}
