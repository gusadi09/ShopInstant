//
//  TransactionsViewModel.swift
//  ShopInstant
//
//  Created by Ewide Dev 5 on 03/09/24.
//

import Foundation

final class TransactionsViewModel: ObservableObject { 
    struct PresentModel: Identifiable {
        let id: String = UUID().uuidString
        let title: String?
        let picture: String?
        let price: String?
        let discount: Int?
        let desc: String?
        let status: BuyStatus?
        let statusDesc: String?
        
        init(title: String?, picture: String?, price: String?, discount: Int?, desc: String?, status: Int?) {
            self.title = title
            self.picture = picture
            self.price = price
            self.discount = discount
            self.desc = desc
            self.status = BuyStatus(rawValue: status ?? 0)
            self.statusDesc = BuyStatus(rawValue: status ?? 0)?.desc
        }
    }
}
