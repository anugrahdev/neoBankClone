//
//  NominalCollectionViewCell.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 08/07/24.
//

import UIKit

class NominalCollectionViewCell: UICollectionViewCell {
    static let identifier = "NominalCollectionViewCell"
    
    private let nominalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(nominalLabel)
        contentView.layer.borderWidth = 0.3
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            nominalLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nominalLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nominalLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nominalLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with nominal: String) {
        nominalLabel.text = nominal
    }
}
