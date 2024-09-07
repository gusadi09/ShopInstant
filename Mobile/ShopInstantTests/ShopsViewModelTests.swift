//
//  ShopsViewModelTests.swift
//  ShopInstantTests
//
//  Created by Ewide Dev 5 on 07/09/24.
//

import XCTest
import SwiftUI
@testable import ShopInstant

final class ShopsViewModelTests: XCTestCase {

    @ObservedObject var sut: ShopsViewModel = ShopsViewModel()

    func testItems_isEmpty() throws {
        XCTAssertTrue(sut.isItemsEmpty())
    }
    
    func testFetchOffers() async throws {
        let expectation = expectation(description: "fetch_shops")
        
        sut.items = []
        
        await sut.fetchOffers()
        
        XCTAssertFalse(sut.isItemsEmpty())
        
        expectation.fulfill()
        
        await fulfillment(of: [expectation], timeout: 10)
    }
    
    func testBuyOffer() async throws {
        let expectation = expectation(description: "buy_offer")
        
        sut.successToBuy = false
        
        await sut.buyNow(from: ShopsViewModel.PresentModel(title: "HEAD SPEED PRO", picture: "https://images.tennis.com/image/private/t_16-9_768/tenniscom-prd/bxdgpnfje6infmzwwix6.jpg", price: "3200000", discount: 10, desc: "Best tennis racquet in the WORLD"))
        
        XCTAssertTrue(sut.successToBuy)
        
        expectation.fulfill()
        
        await fulfillment(of: [expectation], timeout: 10)
    }
}
