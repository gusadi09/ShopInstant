//
//  String+Ext.swift
//  ShopInstant
//
//  Created by Ewide Dev 5 on 05/09/24.
//

import Foundation

extension String {
    var currency: String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        currencyFormatter.roundingMode = .floor
        
        let number = Double(self) ?? 0.0
        
        return currencyFormatter.string(from: NSNumber(value: number)) ?? ""
    }
}
