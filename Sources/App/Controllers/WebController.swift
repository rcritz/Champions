import Vapor
import Leaf

struct WebController: RouteCollection {
    func boot(router: Router) throws {
        router.get(use: indexHandler)
        router.post(ChampionSelect.self, use: selectHandler)
    }
    
    func indexHandler(_ req: Request) throws -> Future<View> {
        let champions = RiotAPI.championList.keys.sorted()
        let context = IndexContext(title: "Select a champion", champions: champions)
        return try req.view().render("index", context)
    }
    
    func selectHandler(_ req: Request, data: ChampionSelect) throws -> Future<View> {
        let context = ChampionDetails(champion: RiotAPI.championList[data.champion]!)
        return try req.view().render("details", context)
    }
}

struct IndexContext: Encodable {
    let title: String
    let champions: [String]
}

struct ChampionSelect: Content {
    let champion: String
}

struct ChampionDetails: Encodable {
    let champion: Champion
}
