import Vapor

struct RiotAPI {
    struct ChamiponLinkData: Decodable {
        var type: String
        var format: String
        var version: String
        var data: [String: Champion]
    }
    
    static var championList: [String: Champion] = [:]
    
    @discardableResult
    static func loadChampions(from client: Client, patch: String) -> Future<HTTPStatus> {
        let urlString = "http://ddragon.leagueoflegends.com/cdn/\(patch)/data/en_US/champion.json"
        return client.get(urlString).flatMap { response in
            try response.content.decode(ChamiponLinkData.self).map { championData in
                championList = championData.data
                return .ok
            }
            .catchMap { _ in
                return .noContent
            }
        }
    }
}
