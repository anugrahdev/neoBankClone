//
//  UIView+Extensions.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 07/07/24.
//

import Foundation
import UIKit

extension UIView {
    func applyTheme() {
        self.backgroundColor = Theme.backgroundColor
        if let label = self as? UILabel {
            label.textColor = Theme.primaryTextColor
        } else if let button = self as? UIButton {
            button.setTitleColor(Theme.primaryTextColor, for: .normal)
        }
    }
}
