//
//  ShopsViewModel.swift
//  ShopInstant
//
//  Created by Ewide Dev 5 on 03/09/24.
//

import Foundation

final class ShopsViewModel: ObservableObject { 
    struct PresentModel: Identifiable {
        let id: String = UUID().uuidString
        let title: String?
        let picture: String?
        let price: String?
        let discount: Int?
        let desc: String?
    }
    
    private let dataSource: OffersRemoteDataSource
    private let trxDataSource: TransactionsRemoteDataSource
    
    @Published var selectedItem: PresentModel?
    @Published var items: [PresentModel] = []
    @Published var isLoading = false
    @Published var error: (Bool, String?) = (false, nil)
    @Published var successToBuy = false
    
    init(
        dataSource: OffersRemoteDataSource = OffersDefaultRemoteDataSource(),
        trxDataSource: TransactionsRemoteDataSource = TransactionsDefaultRemoteDataSource()
    ) {
        self.dataSource = dataSource
        self.trxDataSource = trxDataSource
    }
    
    func refreshOffers() {
        Task {
            await fetchOffers()
        }
    }
    
    @MainActor
    func fetchOffers() async {
        self.isLoading = true
        self.error = (false, nil)
        
        do {
            let data = try await dataSource.getOffers()
            print(data)
            self.isLoading = false
            let mappedItem = data.compactMap {
                $0.toOfferPresentModel()
            }
            
            self.items = mappedItem
        } catch {
            self.isLoading = false
            self.error = (true, error.localizedDescription)
            print(error)
        }
    }
    
    func onBuyPressed(from item: PresentModel) {
        Task {
            await buyNow(from: item)
        }
    }
    
    @MainActor
    func buyNow(from item: PresentModel) async {
        self.isLoading = true
        self.successToBuy = false
        self.error = (false, nil)
        
        do {
            let data = TransactionsViewModel.PresentModel(
                title: item.title,
                picture: item.picture,
                price: item.price,
                discount: item.discount,
                desc: item.desc,
                status: 2)
            
            let _ = try await trxDataSource.postTransaction(with: data)
            self.isLoading = false
            self.successToBuy = true
        } catch {
            self.isLoading = false
            self.successToBuy = false
            self.error = (true, error.localizedDescription)
            print(error)
        }
    }
    
    func isItemsEmpty() -> Bool {
        self.items.isEmpty
    }
}
