//
//  Double+Extensions.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 08/07/24.
//

import Foundation

extension Double {
    func formattedToRupiah() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "IDR"
        formatter.currencySymbol = "Rp. "
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = ","
        formatter.locale = Locale(identifier: "id_ID")
        
        if let formattedString = formatter.string(from: NSNumber(value: self)) {
            return formattedString
        } else {
            return "Rp. 0,00"
        }
    }
}

extension Decimal {
    func formattedToRupiah() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "IDR"
        formatter.currencySymbol = "Rp. "
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = ","
        formatter.locale = Locale(identifier: "id_ID")
        
        // Convert Decimal to NSDecimalNumber for NumberFormatter
        let nsDecimalNumber = NSDecimalNumber(decimal: self)
        
        if let formattedString = formatter.string(from: nsDecimalNumber) {
            return formattedString
        } else {
            return "Rp. 0,00"
        }
    }
}
