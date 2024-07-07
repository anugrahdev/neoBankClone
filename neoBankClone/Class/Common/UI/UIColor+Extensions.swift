//
//  UIColor+Extensions.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 06/07/24.
//

import Foundation
import UIKit

extension UIColor {
    
    class var NeoGrowthColor: UIColor {
        return UIColor(rgb: 0x0EBE5A)
    }
    
    class var NeoTintColor: UIColor {
        return UIColor(rgb: 0xFFD400)
    }
    
    class var NeoTitleColor: UIColor {
        return UIColor(rgb: 0x000000)
    }
    
    class var NeoSubtitleColor: UIColor {
        return UIColor(rgb: 0x515151)
    }
    
    class var NeoLinkColor: UIColor {
        return UIColor(rgb: 0x0085FF)
    }
    
    class var NeoOrange: UIColor {
        return UIColor(rgb: 0xf8541c)
    }
}

extension UIColor {
  convenience init(red: Int, green: Int, blue: Int) {
    assert(red >= 0 && red <= 255, "Invalid red component")
    assert(green >= 0 && green <= 255, "Invalid green component")
    assert(blue >= 0 && blue <= 255, "Invalid blue component")
    
    self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
  }
  
  convenience init(rgb: Int) {
    self.init(
      red: (rgb >> 16) & 0xFF,
      green: (rgb >> 8) & 0xFF,
      blue: rgb & 0xFF
    )
  }
}
