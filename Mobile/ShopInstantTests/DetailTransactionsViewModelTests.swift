//
//  DetailTransactionsViewModelTests.swift
//  ShopInstantTests
//
//  Created by Ewide Dev 5 on 07/09/24.
//

import XCTest
import SwiftUI
@testable import ShopInstant

final class DetailTransactionsViewModelTests: XCTestCase {

    @ObservedObject var sut: DetailTransactionsViewModel = DetailTransactionsViewModel(item: TransactionsViewModel.PresentModel(title: "dummy", picture: "dummy", price: "10000", discount: 10, desc: "dummy", status: 1))

    func testCount_priceAfterDiscount() throws {
        let count = (Int("10000") ?? 0) - (((Int("10000") ?? 0) * 10 / 100))
        
        XCTAssertEqual(sut.priceAfterDisc(price: sut.item.price ?? "0", disc: sut.item.discount ?? 0), String(count).currency)
    }
    
    func testCount_totalDiscount() throws {
        let count = "\(((Int("10000") ?? 0) * (10) / 100))".currency
        
        XCTAssertEqual(sut.totalDisc(price: sut.item.price ?? "0", disc: sut.item.discount ?? 0), count)
    }
    
    func testGet_statusTextColor() throws {
        XCTAssertEqual(sut.textStatusColor(status: sut.item.status), Color.orange)
    }
    
    func testGet_statusBgColor() throws {
        XCTAssertEqual(sut.backgroundStatusColor(status: sut.item.status), Color.yellow.opacity(0.3))
    }
}
