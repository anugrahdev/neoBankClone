//
//  Int+Extensions.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 06/07/24.
//

import Foundation

extension Int {
    func formatNumber() -> String {
        if self >= 1000 && self < 1_000_000 {
            return "\(self / 1000)K"
        } else if self >= 1_000_000 && self < 1_000_000_000 {
            return "\(self / 1_000_000)M"
        } else if self >= 1_000_000_000 {
            return "\(self / 1_000_000_000)B"
        } else {
            return "\(self)"
        }
    }
}
