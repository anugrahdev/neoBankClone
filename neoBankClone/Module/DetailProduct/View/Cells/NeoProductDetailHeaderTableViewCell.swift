//
//  NeoProductDetailHeaderTableViewCell.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 07/07/24.
//

import UIKit

class NeoProductDetailHeaderTableViewCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel.makeTitleLabel()
        label.text = "Deposito FLEXI 1 bulan"
        label.numberOfLines = 0
        return label
    }()
    
    let interestRateLabel: UILabel = {
        let label = UILabel.makeGrowthLabel(fontSize: 18)
        label.text = "7,5% p.a."
        return label
    }()
    
    let durationLabel: UILabel = {
        let label = UILabel.makeRegularLabel()
        label.text = "1 bulan"
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel.makeSubtitleLabel()
        label.text = "Suku bunga saat ini akan dihitung berdasarkan \"suku bunga dasar + suku bunga tambahan\" dan suku bunga saat roll-over akan dihitung berdasarkan suku bunga yang berlaku di tanggal roll-over."
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(titleLabel)
        addSubview(interestRateLabel)
        addSubview(durationLabel)
        addSubview(descriptionLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        interestRateLabel.translatesAutoresizingMaskIntoConstraints = false
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            interestRateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            interestRateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            durationLabel.bottomAnchor.constraint(equalTo: interestRateLabel.bottomAnchor, constant: 0),
            durationLabel.leadingAnchor.constraint(equalTo: interestRateLabel.trailingAnchor, constant: 8),
            
            descriptionLabel.topAnchor.constraint(equalTo: interestRateLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
        
        ])
    }
    
    func configure(with model: NeoProductModel) {
        titleLabel.text = model.productName ?? ""
        durationLabel.text = extractPeriod(from: model.productName ?? "")
        interestRateLabel.text = "\(model.rate ?? 0)% p.a"
    }
    
    func extractPeriod(from string: String) -> String? {
        let pattern = "\\d+ (days|months|year|years)"
        if let range = string.range(of: pattern, options: .regularExpression) {
            return String(string[range])
        }
        return nil
    }
}
