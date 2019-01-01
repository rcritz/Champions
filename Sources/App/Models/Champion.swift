import Foundation

struct Champion: Codable {
  var version: String
  var id: String
  var key: String
  var name: String
  var title: String
  var blurb: String
  var info: ChampionInfo
  var image: ChampionImage
  var tags: [String]
  var partype: String
  var stats: ChampionStats
}

struct ChampionInfo: Codable {
  var attack: Int
  var defense: Int
  var magic: Int
  var difficulty: Int
}

struct ChampionImage: Codable {
  var full: String
  var sprite: String
  var group: String
  var x: Int
  var y: Int
  var w: Int
  var h: Int
}

struct ChampionStats: Codable {
  var hp: Double
  var hpperlevel: Double
  var mp: Double
  var mpperlevel: Double
  var movespeed: Double
  var armor: Double
  var armorperlevel: Double
  var spellblock: Double
  var spellblockperlevel: Double
  var attackrange: Int
  var hpregen: Double
  var hpregenperlevel: Double
  var mpregen: Double
  var mpregenperlevel: Double
  var crit: Double
  var critperlevel: Double
  var attackdamage: Double
  var attackdamageperlevel: Double
  var attackspeedperlevel: Double
  var attackspeed: Double
}
