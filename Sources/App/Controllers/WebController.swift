import Vapor
import Leaf

struct WebController: RouteCollection {
    func boot(router: Router) throws {
        router.get(use: indexHandler)
    }
    
    func indexHandler(_ req: Request) throws -> Future<View> {
        let champions = RiotAPI.championList.keys.sorted()
        let context = IndexContext(title: "Select a champion", champions: champions)
        return try req.view().render("index", context)
    }
}

struct IndexContext: Encodable {
    let title: String
    let champions: [String]
}
