//
//  UITextField+Extensions.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 08/07/24.
//

import Foundation
import UIKit

extension UITextField {
    
    private static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.groupingSize = 3
        return formatter
    }()
    
    func enableNumberFormatting() {
        self.addTarget(self, action: #selector(formatNumber), for: .editingChanged)
    }
    
    @objc private func formatNumber() {
        guard let text = self.text else { return }
        
        let cleanText = text.replacingOccurrences(of: ".", with: "")
        if let number = Int(cleanText) {
            self.text = UITextField.numberFormatter.string(from: NSNumber(value: number))
        } else {
            self.text = ""
        }
    }
    
    func setBorderValid(_ isValid: Bool) {
        self.layer.borderColor = isValid ? UIColor.clear.cgColor : UIColor.red.cgColor
        self.layer.borderWidth = isValid ? 0 : 1
    }
}
