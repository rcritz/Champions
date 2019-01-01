import Vapor
import Leaf

struct WebController: RouteCollection {
  func boot(router: Router) throws {
    router.get(use: indexHandler)
    router.post(ChampionSelect.self, use: selectHandler)
    router.get("version", use: versionHandler)
    router.post(ChangeVersion.self, at: "version", use: versionPostHandler)
  }
  
  func indexHandler(_ req: Request) throws -> Future<View> {
    let champions = RiotAPI.championList.keys.sorted()
    let context = IndexContext(champions: champions)
    return try req.view().render("index", context)
  }
  
  func selectHandler(_ req: Request, data: ChampionSelect) throws -> Future<View> {
    let context = ChampionDetails(champion: RiotAPI.championList[data.champion]!)
    return try req.view().render("details", context)
  }
  
  func versionHandler(_ req: Request) throws -> Future<View> {
    let context: VersionContext
    if req.query[Bool.self, at: "error"] != nil {
      context = VersionContext(version: RiotAPI.version, error: true)
    } else {
      context = VersionContext(version: RiotAPI.version)
    }
    return try req.view().render("version", context)
  }
  
  func versionPostHandler(_ req: Request, data: ChangeVersion) throws -> Future<Response> {
    return try RiotAPI.loadChampions(from: req.make(Client.self), patch: data.version).map { response in
      switch response {
      case .ok:
        return req.redirect(to: "/")
      case .noContent:
        return  req.redirect(to: "/version?error")
      default:
        throw Abort(.internalServerError)
      }
    }
    .catchMap { _ in
      return req.redirect(to: "/version?error")
    }
  }
}

struct IndexContext: Encodable {
  let title = "Select a champion"
  let champions: [String]
}

struct ChampionSelect: Content {
  let champion: String
}

struct ChampionDetails: Encodable {
  let champion: Champion
}

struct VersionContext: Encodable {
  let title = "Change Version"
  let version: String
  let error: Bool
  
  init(version: String, error: Bool = false) {
    self.version = version
    self.error = error
  }
}

struct ChangeVersion: Content {
  let version: String
}
