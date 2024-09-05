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
    
    private let dataSource: FirestoreDataSource
    
    @Published var selectedItem: PresentModel?
    @Published var items: [PresentModel] = []
    @Published var isLoading = false
    @Published var error: (Bool, String?) = (false, nil)
    @Published var successToBuy = false
    
    init(dataSource: FirestoreDataSource = FirestoreDefaultDataSource()) {
        self.dataSource = dataSource
    }
    
    func fetchOffers() async {
        self.isLoading = true
        self.error = (false, nil)
        
        do {
            let data = try await dataSource.fetch(from: Collection.offers.id)
            print(data)
            self.isLoading = false
            let mappedItem = data.compactMap { item in
                PresentModel(
                    title: item["title"] as? String,
                    picture: item["picture"] as? String,
                    price: item["price"] as? String,
                    discount: item["discount"] as? Int,
                    desc: item["desc"] as? String
                )
            }
            
            self.items = mappedItem
        } catch {
            self.isLoading = false
            self.error = (true, error.localizedDescription)
            print(error)
        }
    }
    
    func buyNow(from item: PresentModel) async {
        self.isLoading = true
        self.successToBuy = false
        self.error = (false, nil)
        
        do {
            let data = [
                "title": item.title ?? "",
                "picture": item.picture ?? "",
                "price": item.price ?? "",
                "discount": item.discount ?? 0,
                "desc": item.desc ?? "",
                "status": BuyStatus.onDelivery.rawValue
            ] as [String : Any]
            
            let _ = try await dataSource.add(from: Collection.buyItems.id, with: data)
            self.isLoading = false
            self.successToBuy = true
        } catch {
            self.isLoading = false
            self.error = (true, error.localizedDescription)
            print(error)
        }
    }
}
