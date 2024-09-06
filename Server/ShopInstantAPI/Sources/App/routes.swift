import Fluent
import Vapor

func routes(_ app: Application) throws {
    let offerController = OffersController()

    try app.register(collection: offerController)
}
