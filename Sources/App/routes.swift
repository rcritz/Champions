import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
  let webController = WebController()
  try router.register(collection: webController)
}
