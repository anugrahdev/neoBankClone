//
//  UIViewController+Extensions.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 07/07/24.
//

import UIKit
import Foundation


extension UIViewController {
    
    func setNavigationBarTitle(title: String, isCentered: Bool) {
        let titleLabel = UILabel.makeTitleLabel(weight: .bold)
        titleLabel.text = title
        
        if isCentered {
            self.navigationItem.titleView = titleLabel
        } else {
            let titleItem = UIBarButtonItem(customView: titleLabel)
            self.navigationItem.leftBarButtonItem = titleItem
        }

    }

    func setNavigationBarRightButton(title: String, fontName: String = "System", fontSize: CGFloat, textColor: UIColor, action: Selector) {
        let rightButton = UIBarButtonItem(title: title, style: .plain, target: self, action: action)
        rightButton.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: fontName, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize),
            NSAttributedString.Key.foregroundColor: textColor
        ], for: .normal)
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    func removeBackButtonText() {
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backButtonTitle = ""
        }
    }
}
