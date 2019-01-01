import Vapor

/// Called after your application has initialized.
public func boot(_ app: Application) throws {
  try RiotAPI.loadChampions(from: app.make(Client.self), patch: "8.24.1")
}
