import ComposableArchitecture
import SwiftUI

struct CharacterDetailView: View {
    @Bindable var store: StoreOf<CharacterDetailReducer>

    var body: some View {
        List {
            Section {
                VStack {
                    if !store.detail.images.isEmpty {
                        TabView {
                            ForEach(store.detail.images, id: \.self) { image in
                                if let url = URL(string: image) {
                                    AsyncLazyImageView(url: url)
                                }
                            }
                        }
                        .frame(height: 250)
                        .tabViewStyle(PageTabViewStyle())
                        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
                    }
                    Text(store.detail.name)
                        .font(.title)
                    if let rank = store.detail.rank {
                        if case let VariableRank.rank(value) = rank, let value {
                            if let registration = value.ninjaRegistration {
                                Text("No. registro: " + registration)
                            }
                        } else if case let VariableRank.stringArray(array) = rank {
                            ForEach(array, id: \.self) { nature in
                                Text(nature)
                            }
                        }
                    }
                }
            }
            if let rank = store.detail.rank,
               case let VariableRank.rank(value) = rank,
               let value,
               let rank = value.ninjaRank {
                Section {
                    PeriodView(title: nil, period: rank)
                } header: {
                    Text("Rangos obtenidos")
                }
            }
            if let family = store.detail.family {
                Section {
                    if let father = family.father {
                        Text("Father: \(father)")
                    }
                    if let father2 = family.father2 {
                        Text("Father: \(father2)")
                    }
                    if let fosterFather = family.fosterFather {
                        Text("Foster Father: \(fosterFather)")
                    }
                    if let adoptiveFather = family.adoptiveFather {
                        Text("Adoptive father: \(adoptiveFather)")
                    }
                    if let godfather = family.godfather {
                        Text("Godfather: \(godfather)")
                    }
                    if let grandfather = family.grandfather {
                        Text("Grandfather: \(grandfather)")
                    }
                    if let grandfather2 = family.grandfather2 {
                        Text("Grandfather: \(grandfather2)")
                    }
                    if let greatGrandfather = family.greatGrandfather {
                        Text("Great Grandfather: \(greatGrandfather)")
                    }
                    if let greatGreatGrandfather = family.greatGreatGrandfather {
                        Text("Great Great Grandfather: \(greatGreatGrandfather)")
                    }
                    if let greatGreatGranddaughter = family.greatGreatGranddaughter {
                        Text("Great Great Granddaughter: \(greatGreatGranddaughter)")
                    }
                    if let greatGreatGrandson2 = family.greatGreatGrandson2 {
                        Text("Great Great Grandson: \(greatGreatGrandson2)")
                    }
                    if let ancestor = family.ancestor{
                        Text("Ancestor: \(ancestor)")
                    }
                    if let mother = family.mother {
                        Text("Mother: \(mother)")
                    }
                    if let mother2 = family.mother2 {
                        Text("Mother: \(mother2)")
                    }
                    if let grandmother = family.grandmother {
                        Text("Grandmother: \(grandmother)")
                    }
                    if let familyGrandmother = family.familyGrandmother {
                        Text("Family Grandmother: \(familyGrandmother)")
                    }
                    if let adoptiveMother = family.adoptiveMother {
                        Text("Adoptive mother: \(adoptiveMother)")
                    }
                    if let wife = family.wife {
                        Text("Wife: \(wife)")
                    }
                    if let wife2 = family.wife2 {
                        Text("Wife: \(wife2)")
                    }
                    if let spouse = family.spouse {
                        Text("Spouse: \(spouse)")
                    }
                    if let husband = family.husband {
                        Text("Husband: \(husband)")
                    }
                    if let lover = family.lover {
                        Text("Lover: \(lover)")
                    }
                    if let lover2 = family.lover2 {
                        Text("Lover: \(lover2)")
                    }
                    if let son = family.son {
                        Text("Son: \(son)")
                    }
                    if let son2 = family.son2 {
                        Text("Son: \(son2)")
                    }
                    if let grandson = family.grandson {
                        Text("Grandson: \(grandson)")
                    }
                    if let grandson2 = family.grandson2 {
                        Text("Grandson: \(grandson2)")
                    }
                    if let adoptiveSon = family.adoptiveSon {
                        Text("Adoptive son: \(adoptiveSon)")
                    }
                    if let adoptiveSons = family.adoptiveSons {
                        Text("Adoptive sons: \(adoptiveSons)")
                    }
                    if let fosterSon = family.fosterSon {
                        Text("Foster son: \(fosterSon)")
                    }
                    if let adoptiveGrandson = family.adoptiveGrandson {
                        Text("Adoptive grandson: \(adoptiveGrandson)")
                    }
                    if let cloneSon = family.cloneSon {
                        Text("Clone son: \(cloneSon)")
                    }
                    if let daughter = family.daughter {
                        Text("Daughter: \(daughter)")
                    }
                    if let granddaughter = family.granddaughter {
                        Text("Grand Daughter: \(granddaughter)")
                    }
                    if let granddaughter2 = family.granddaughter2 {
                        Text("Grand Daughter: \(granddaughter2)")
                    }
                    if let brother = family.brother {
                        Text("Brother: \(brother)")
                    }
                    if let brother2 = family.brother2 {
                        Text("Brother: \(brother2)")
                    }
                    if let twinBrother = family.twinBrother {
                        Text("Twin Brother: \(twinBrother)")
                    }
                    if let youngerBrother = family.youngerBrother {
                        Text("Younger Brother: \(youngerBrother)")
                    }
                    if let youngerBrother2 = family.youngerBrother2 {
                        Text("Younger Brother: \(youngerBrother2)")
                    }
                    if let fiancee = family.fiancee {
                        Text("Fiancée: \(fiancee)")
                    }
                    if let vessel = family.vessel {
                        Text("Vessel: \(vessel)")
                    }
                    if let olderBrother = family.olderBrother {
                        Text("Older Brother: \(olderBrother)")
                    }
                    if let adoptiveGrandfather = family.adoptiveGrandfather {
                        Text("Adoptive Grandfather: \(adoptiveGrandfather)")
                    }
                    if let adoptiveGrandmother = family.adoptiveGrandmother {
                        Text("Adoptive Grandmother: \(adoptiveGrandmother)")
                    }
                    if let adoptiveGranduncle = family.adoptiveGranduncle {
                        Text("Adoptive Granduncle: \(adoptiveGranduncle)")
                    }
                    if let adoptiveUncle = family.adoptiveUncle {
                        Text("Adoptive uncle: \(adoptiveUncle)")
                    }
                    if let adoptiveNephew = family.adoptiveNephew {
                        Text("Adoptive nephew: \(adoptiveNephew)")
                    }
                    if let adoptiveNiece = family.adoptiveNiece {
                        Text("Adoptive niece: \(adoptiveNiece)")
                    }
                    if let adoptiveAunt = family.adoptiveAunt {
                        Text("Adoptive aunt: \(adoptiveAunt)")
                    }
                    if let adoptiveBrother = family.adoptiveBrother {
                        Text("Adoptive Brother: \(adoptiveBrother)")
                    }
                    if let geneticTemplateParent = family.geneticTemplateParent {
                        Text("Genetic Template Parent: \(geneticTemplateParent)")
                    }
                    if let geneticTemplate = family.geneticTemplate {
                        Text("Genetic Template: \(geneticTemplate)")
                    }
                    if let geneticSource = family.geneticSource {
                        Text("Genetic source: \(geneticSource)")
                    }
                    if let cloneBrother = family.cloneBrother {
                        Text("Clone Brother: \(cloneBrother)")
                    }
                    if let sister = family.sister {
                        Text("Sister: \(sister)")
                    }
                    if let sibling = family.sibling {
                        Text("Sibling: \(sibling)")
                    }
                    if let cousin = family.cousin {
                        Text("Cousin: \(cousin)")
                    }
                    if let firstCousinOnceRemoved = family.firstCousinOnceRemoved {
                        Text("First Cousin Once Removed: \(firstCousinOnceRemoved)")
                    }
                    if let youngerCousin = family.youngerCousin {
                        Text("Younger Cousin: \(youngerCousin)")
                    }
                    if let adoptiveCousin = family.adoptiveCousin {
                        Text("Adoptive Cousin: \(adoptiveCousin)")
                    }
                    if let nephew = family.nephew {
                        Text("Nephew: \(nephew)")
                    }
                    if let niece = family.niece {
                        Text("Niece: \(niece)")
                    }
                    if let uncle = family.uncle {
                        Text("Uncle: \(uncle)")
                    }
                    if let uncle2 = family.uncle2 {
                        Text("Uncle: \(uncle2)")
                    }
                    if let aunt = family.aunt {
                        Text("Aunt: \(aunt)")
                    }
                    if let granduncle = family.granduncle {
                        Text("Granduncle: \(granduncle)")
                    }
                    if let grandNephew = family.grandNephew {
                        Text("GrandNephew: \(grandNephew)")
                    }
                    if let grandNiece = family.grandNiece {
                        Text("GrandNiece: \(grandNiece)")
                    }
                    if let clone = family.clone {
                        Text("Clone: \(clone)")
                    }
                    if let alteredClone = family.alteredClone {
                        Text("Altered Clone: \(alteredClone)")
                    }
                    if let host = family.host {
                        Text("Host: \(host)")
                    }
                    if let creator = family.creator {
                        Text("Creator: \(creator)")
                    }
                    if let creation = family.creation {
                        Text("Creation: \(creation)")
                    }
                    if let creations = family.creations {
                        Text("Creations: \(creations)")
                    }
                    if let depoweredForm = family.depoweredForm {
                        Text("Depowered form: \(depoweredForm)")
                    }
                    if let originalForm = family.originalForm {
                        Text("original form: \(originalForm)")
                    }
                    if let incarnation = family.incarnationWithTheGodTree {
                        Text("Incarnation with the god tree: \(incarnation)")
                    }
                    if let pet = family.pet {
                        Text("Pet: \(pet)")
                    }
                } header: {
                    Text("Family")
                }

            }
            if let personal = store.detail.personal {
                if case let VariablePersonal.stringArray(array) = personal {
                    ForEach(array, id: \.self) { person in
                        Text(person)
                    }
                } else if case let VariablePersonal.personal(value) = personal {
                    Section {
                        if let sex = value.sex {
                            Text("Sex: \(sex.rawValue.capitalized)")
                        }
                        if let birthdate = value.birthdate {
                            Text("Cumpleaños: \(birthdate)")
                        }
                        if let bloodType = value.bloodType {
                            Text("Tipo de sangre: \(bloodType.rawValue.uppercased())")
                        }
                        if let tailedBeast = value.tailedBeast {
                            Text("Bestia de cola: \(tailedBeast)")
                        }
                        if let species = value.species {
                            Text("Especie: \(species)")
                        }
                        if let status = value.status {
                            Text("Estado: \(status)")
                        }
                        if let age = value.age {
                            PeriodView(title: "Edades", period: age)
                        }
                        if let height = value.height {
                            PeriodView(title: "Estatura", period: height)
                        }
                        if let weight = value.weight {
                            PeriodView(title: "Peso", period: weight)
                        }
                    } header: {
                        Text("Personal Information")
                    }

                    if let partner = value.partner {
                        ClanSectionView(title: "Partner", clan: partner)
                    }

                    if let occupation = value.occupation {
                        ClanSectionView(title: "Occupation", clan: occupation)
                    }

                    if let titles = value.titles {
                        Section {
                            ForEach(titles, id: \.self) { nature in
                                Text(nature)
                            }
                        } header: {
                            Text("Titulos")
                        }
                    }
                    if let kekkeiGenkai = value.kekkeiGenkai {
                        ClanSectionView(title: "Kekkei Genkai", clan: kekkeiGenkai)
                    }
                    if let kekkeiMōra = value.kekkeiMōra {
                        ClanSectionView(title: "Kekkei Mōra", clan: kekkeiMōra)
                    }
                    if let classification = value.classification {
                        ClanSectionView(title: "Classification", clan: classification)
                    }
                    if let clan = value.clan {
                        ClanSectionView(title: "Clan", clan: clan)
                    }
                    if let affiliation = value.affiliation {
                        ClanSectionView(title: "Affiliation", clan: affiliation)
                    }
                    if let team = value.team {
                        ClanSectionView(title: "Team", clan: team)
                    }
                }
            }
            if let natures = store.detail.natureTypes {
                Section {
                    LazyVStack {
                        ForEach(natures, id: \.self) { nature in
                            Text(nature)
                        }
                    }
                } header: {
                    Text("Tipos de chakras")
                }
            }
            if !store.detail.jutsus.isEmpty {
                Section {
                    LazyVStack {
                        ForEach(store.detail.jutsus, id: \.self) { nature in
                            Text(nature)
                        }
                    }
                } header: {
                    Text("Jutsus")
                }
            }
            if let natures = store.detail.uniqueTraits {
                Section {
                    LazyVStack {
                        ForEach(natures, id: \.self) { nature in
                            Text(nature)
                        }
                    }
                } header: {
                    Text("Rasgos únicos")
                }
            }
            if let natures = store.detail.tools {
                Section {
                    LazyVStack {
                        ForEach(natures, id: \.self) { nature in
                            Text(nature)
                        }
                    }
                } header: {
                    Text("Herramientas ninja")
                }
            }
            if let actors = store.detail.voiceActors {
                Section {
                    if let eng = actors.englishActors {
                        Text("English Actors:")
                        if case let Clan.string(value) = eng {
                            Text(value)
                        } else if case let Clan.stringArray(array) = eng {
                            ForEach(array, id: \.self) { nature in
                                Text(nature)
                            }
                        }
                    }
                    if let jap = actors.japaneseActors {
                        Text("Japanish Actors:")
                        if case let Clan.string(value) = jap {
                            Text(value)
                        } else if case let Clan.stringArray(array) = jap {
                            ForEach(array, id: \.self) { nature in
                                Text(nature)
                            }
                        }
                    }
                } header: {
                    Text("Voice actors")
                }

            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    store.send(.closeDetailButton)
                } label: {
                    Image(systemName: "x.circle")
                }
            }
        }
    }
}

#Preview {
    CharacterDetailView(
        store: Store(
            initialState: CharacterDetailReducer.State(
                detail: .mock
            )
        ) { CharacterDetailReducer() }
    )
}

struct PeriodView: View {

    let title: String?
    let period: HistoryPeriod

    var body: some View {
        VStack {
            if let title {
                Text(title)
            }
            if let partI = period.academyGraduate {
                Text("Academy Graduate: \(partI)")
            }
            if let partI = period.chuninPromotion {
                Text("Chunin Promotion: \(partI)")
            }
            if let partI = period.partI {
                Text("Part I: \(partI)")
            }
            if let partI = period.partII {
                Text("Part II: \(partI)")
            }
            if let partI = period.blankPeriod {
                Text("Blank Period: \(partI)")
            }
            if let partI = period.gaiden {
                Text("Gaiden: \(partI)")
            }
            if let partI = period.borutoMovie {
                Text("Boruto Movie: \(partI)")
            }
            if let partI = period.borutoManga {
                Text("Boruto Manga: \(partI)")
            }
        }
    }
}

struct ClanSectionView: View {

    let title: String
    let clan: Clan

    var body: some View {
        Section {
            if case let Clan.string(value) = clan {
                Text(value)
            } else if case let Clan.stringArray(array) = clan {
                ForEach(array, id: \.self) { nature in
                    Text(nature)
                }
            }
        } header: {
            Text(title)
        }
    }
}
