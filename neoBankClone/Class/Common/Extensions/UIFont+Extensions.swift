//
//  UIFont+Extensions.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 07/07/24.
//

import UIKit

extension UIFont {
    static func appFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
