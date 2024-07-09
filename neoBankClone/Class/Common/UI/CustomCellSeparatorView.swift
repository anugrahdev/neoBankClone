//
//  CustomCellSeparator.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 07/07/24.
//

import Foundation
import UIKit

class CustomCellSeparatorView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        self.backgroundColor = .NeoGreyolor 
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
