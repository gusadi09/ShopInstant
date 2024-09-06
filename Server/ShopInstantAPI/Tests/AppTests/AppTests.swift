@testable import App
import XCTVapor
import Fluent

final class AppTests: XCTestCase {
    var app: Application!
    
    override func setUp() async throws {
        self.app = try await Application.make(.testing)
        try await configure(app)
        try await app.autoMigrate()
    }
    
    override func tearDown() async throws { 
        try await app.autoRevert()
        try await self.app.asyncShutdown()
        self.app = nil
    }
    
    func testOfferIndex() async throws {
        let sampleOffers = [
            Offer(offerName: "Sample Offer 1", offerImageUrl: "https://images.tennis.com/image/private/t_16-9_768/tenniscom-prd/bxdgpnfje6infmzwwix6.jpg", offerPrice: "3200000", offerDiscount: 10, offerDesc: "Sample Desc of Offer"),
            Offer(offerName: "Sample Offer 2", offerImageUrl: "https://media.istockphoto.com/id/1271796113/photo/women-is-holding-handbag-near-luxury-car.jpg?s=612x612&w=0&k=20&c=-jtXLmexNgRa-eKqA1X8UJ8QYWhW7XgDiWNmzuuCHmM=", offerPrice: "3200000", offerDiscount: 10, offerDesc: "Sample Desc of Offer"),
        ]
        try await sampleOffers.create(on: self.app.db)
        
        try await self.app.test(.GET, "offers", afterResponse: { res async throws in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(
                try res.content.decode([OfferDTO].self).sorted(by: { $0.offerName ?? "" < $1.offerName ?? "" }),
                sampleOffers.map { $0.toDTO() }.sorted(by: { $0.offerName ?? "" < $1.offerName ?? "" })
            )
        })
    }
    
    func testOfferCreate() async throws {
        let newDTO = OfferDTO(id: UUID(), offerName: "Sample Offer 1", offerImageUrl: "https://images.tennis.com/image/private/t_16-9_768/tenniscom-prd/bxdgpnfje6infmzwwix6.jpg", offerPrice: "3200000", offerDiscount: 10, offerDesc: "Sample Desc of Offer")
        
        try await self.app.test(.POST, "offers", beforeRequest: { req in
            try req.content.encode(newDTO)
        }, afterResponse: { res async throws in
            XCTAssertEqual(res.status, .ok)
            let models = try await Offer.query(on: self.app.db).all()
            XCTAssertEqual(models.map { $0.toDTO().offerName }, [newDTO.offerName])
        })
    }
    
    func testOfferDelete() async throws {
        let sampleOffers = [
            Offer(offerName: "Sample Offer 1", offerImageUrl: "https://images.tennis.com/image/private/t_16-9_768/tenniscom-prd/bxdgpnfje6infmzwwix6.jpg", offerPrice: "3200000", offerDiscount: 10, offerDesc: "Sample Desc of Offer"),
            Offer(offerName: "Sample Offer 2", offerImageUrl: "https://media.istockphoto.com/id/1271796113/photo/women-is-holding-handbag-near-luxury-car.jpg?s=612x612&w=0&k=20&c=-jtXLmexNgRa-eKqA1X8UJ8QYWhW7XgDiWNmzuuCHmM=", offerPrice: "3200000", offerDiscount: 10, offerDesc: "Sample Desc of Offer"),
        ]
        try await sampleOffers.create(on: app.db)
        
        try await self.app.test(.DELETE, "offers/\(sampleOffers[0].requireID())", afterResponse: { res async throws in
            XCTAssertEqual(res.status, .noContent)
            let model = try await Offer.find(sampleOffers[0].id, on: self.app.db)
            XCTAssertNil(model)
        })
    }
    
    func testTrxIndex() async throws {
        let sampleTrx = [
            Transaction(itemName: "Sample Offer 1", itemImageUrl: "https://images.tennis.com/image/private/t_16-9_768/tenniscom-prd/bxdgpnfje6infmzwwix6.jpg", itemPrice: "3200000", itemDiscount: 10, itemDesc: "Sample Desc of Offer", itemStatus: 1),
            Transaction(itemName: "Sample Offer 2", itemImageUrl: "https://media.istockphoto.com/id/1271796113/photo/women-is-holding-handbag-near-luxury-car.jpg?s=612x612&w=0&k=20&c=-jtXLmexNgRa-eKqA1X8UJ8QYWhW7XgDiWNmzuuCHmM=", itemPrice: "3200000", itemDiscount: 10, itemDesc: "Sample Desc of Offer", itemStatus: 2),
        ]
        try await sampleTrx.create(on: self.app.db)
        
        try await self.app.test(.GET, "transactions", afterResponse: { res async throws in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(
                try res.content.decode([TransactionDTO].self).sorted(by: { $0.itemName ?? "" < $1.itemName ?? "" }),
                sampleTrx.map { $0.toDTO() }.sorted(by: { $0.itemName ?? "" < $1.itemName ?? "" })
            )
        })
    }
    
    func testTrxCreate() async throws {
        let newDTO = TransactionDTO(id: UUID(), itemName: "Sample Offer 1", itemImageUrl: "https://images.tennis.com/image/private/t_16-9_768/tenniscom-prd/bxdgpnfje6infmzwwix6.jpg", itemPrice: "3200000", itemDiscount: 10, itemDesc: "Sample Desc of Offer", itemStatus: 1)
        
        try await self.app.test(.POST, "transactions", beforeRequest: { req in
            try req.content.encode(newDTO)
        }, afterResponse: { res async throws in
            XCTAssertEqual(res.status, .ok)
            let models = try await Transaction.query(on: self.app.db).all()
            XCTAssertEqual(models.map { $0.toDTO().itemName }, [newDTO.itemName])
        })
    }
    
    func testTrxDelete() async throws {
        let sampleTrx = [
            Transaction(itemName: "Sample Offer 1", itemImageUrl: "https://images.tennis.com/image/private/t_16-9_768/tenniscom-prd/bxdgpnfje6infmzwwix6.jpg", itemPrice: "3200000", itemDiscount: 10, itemDesc: "Sample Desc of Offer", itemStatus: 1),
            Transaction(itemName: "Sample Offer 2", itemImageUrl: "https://media.istockphoto.com/id/1271796113/photo/women-is-holding-handbag-near-luxury-car.jpg?s=612x612&w=0&k=20&c=-jtXLmexNgRa-eKqA1X8UJ8QYWhW7XgDiWNmzuuCHmM=", itemPrice: "3200000", itemDiscount: 10, itemDesc: "Sample Desc of Offer", itemStatus: 2),
        ]
        try await sampleTrx.create(on: app.db)
        
        try await self.app.test(.DELETE, "transactions/\(sampleTrx[0].requireID())", afterResponse: { res async throws in
            
            print(res)
            XCTAssertEqual(res.status, .noContent)
            let model = try await Offer.find(sampleTrx[0].id, on: self.app.db)
            XCTAssertNil(model)
        })
    }
}

extension OfferDTO: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id && lhs.offerName == rhs.offerName
    }
}

extension TransactionDTO: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id && lhs.itemName == rhs.itemName
    }
}
