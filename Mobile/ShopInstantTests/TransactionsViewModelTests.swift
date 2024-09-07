//
//  TransactionsViewModelTests.swift
//  ShopInstantTests
//
//  Created by Ewide Dev 5 on 07/09/24.
//

import XCTest
import SwiftUI
@testable import ShopInstant

final class TransactionsViewModelTests: XCTestCase {

    @ObservedObject var sut: TransactionsViewModel = TransactionsViewModel()

    func testItems_isEmpty() throws {
        XCTAssertTrue(sut.isItemsEmpty())
    }
    
    func testFetchTransactions() async throws {
        let expectation = expectation(description: "fetch_trx")
        
        sut.items = []
        
        await sut.fetchTrx()
        
        XCTAssertFalse(sut.isItemsEmpty())
        
        expectation.fulfill()
        
        await fulfillment(of: [expectation], timeout: 10)
    }
}
