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
        let title: String
        let picture: String = "test"
        let price: String
        let discount: Int
        let desc: String = """
Elevate your style with our **Elegant Leather Tote Bag**, a perfect blend of sophistication and functionality. Crafted from premium, full-grain leather, this tote exudes luxury and durability. Its sleek design makes it ideal for both professional and casual settings, whether you’re heading to the office, running errands, or enjoying a day out.

**Key Features:**

- **Genuine Full-Grain Leather**: Our tote is made from high-quality leather that ages beautifully, developing a rich patina over time.
- **Spacious Interior**: Designed with ample room to accommodate all your essentials. The main compartment features a secure zip closure to keep your belongings safe.
- **Multiple Pockets**: Includes an interior zippered pocket and two slip pockets for easy organization of smaller items like keys and phones.
- **Comfortable Handles**: The double-stitched handles are crafted for comfort and durability, allowing you to carry the tote by hand or over the shoulder.
- **Versatile Design**: Available in classic colors such as Black, Brown, and Tan, making it easy to pair with any outfit.
- **Dimensions**: 16" x 12" x 5" – perfect for daily use without being bulky.

**Care Instructions:**

To maintain the pristine condition of your leather tote, clean with a soft, damp cloth and regularly apply a leather conditioner. Avoid prolonged exposure to water and direct sunlight.

**Why You'll Love It:**

The **Elegant Leather Tote Bag** is more than just an accessory; it's a statement piece that combines practical design with timeless style. Whether you're heading to work, shopping, or traveling, this tote will keep you organized and chic.
"""
    }
    
    @Published var selectedItem: PresentModel?
    @Published var items: [PresentModel] = [
        PresentModel(title: "GUCCI Shopping Bag", price: "1200", discount: 10),
        PresentModel(title: "LOUIS Shopping Bag", price: "1200", discount: 15),
        PresentModel(title: "DALLAS Shopping Bag", price: "1200", discount: 12),
        PresentModel(title: "ERIGO Shopping Bag", price: "1200", discount: 11),
        PresentModel(title: "MILLS Shopping Bag", price: "1200", discount: 16),
        PresentModel(title: "ADIDAS Shopping Bag", price: "1200", discount: 20),
        PresentModel(title: "NIKE Shopping Bag", price: "1200", discount: 50),
        PresentModel(title: "POLO Shopping Bag", price: "1200", discount: 14),
        PresentModel(title: "DIOR Shopping Bag", price: "1200", discount: 17),
    ]
}
