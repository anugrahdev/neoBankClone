//
//  UILabel+Extensions.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 06/07/24.
//

import Foundation
import UIKit

extension UILabel {

    static func makeTitleLabel(text: String? = nil, fontSize: CGFloat = 16, weight: UIFont.Weight = .bold, textColor: UIColor = .NeoTitleColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        label.textColor = textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    static func makeSubtitleLabel(text: String? = nil, fontSize: CGFloat = 12, weight: UIFont.Weight = .medium, textColor: UIColor = .NeoSubtitleColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        label.textColor = textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func makeRegularLabel(text: String? = nil, fontSize: CGFloat = 14, weight: UIFont.Weight = .medium, textColor: UIColor = .NeoTitleColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        label.textColor = textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func makeGrowthLabel(text: String? = nil, fontSize: CGFloat = 16, weight: UIFont.Weight = .bold, textColor: UIColor = .NeoGrowthColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        label.textColor = textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
