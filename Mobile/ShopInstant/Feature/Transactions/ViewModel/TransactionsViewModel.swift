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
        
        func toModel() -> Transaction {
            Transaction(
                id: UUID(),
                itemName: title,
                itemImageUrl: picture,
                itemPrice: price,
                itemDiscount: discount,
                itemDesc: desc,
                itemStatus: status?.rawValue
            )
        }
    }
    
    private let dataSource: TransactionsRemoteDataSource
    
    @Published var selectedItem: PresentModel?
    @Published var items: [PresentModel] = []
    @Published var isLoading = false
    @Published var error: (Bool, String?) = (false, nil)
    
    init(dataSource: TransactionsRemoteDataSource = TransactionsDefaultRemoteDataSource()) {
        self.dataSource = dataSource
    }
    
    func refreshTrxs() {
        Task {
            await fetchTrx()
        }
    }
    
    @MainActor
    func fetchTrx() async {
        self.isLoading = true
        self.error = (false, nil)
        
        do {
            let data = try await dataSource.getTransactions()
            print(data)
            self.isLoading = false
            let mappedItem = data.compactMap {
                $0.toTransactionPresentModel()
            }
            
            self.items = mappedItem
        } catch {
            self.isLoading = false
            self.error = (true, error.localizedDescription)
            print(error)
        }
    }
}
