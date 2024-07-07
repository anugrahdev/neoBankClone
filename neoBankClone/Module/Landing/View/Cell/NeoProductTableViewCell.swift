//
//  NeoProductTableViewCell.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 06/07/24.
//

import UIKit

import UIKit

class NeoProductTableViewCell: UITableViewCell {

    // Define UI components
    let titleLabel = UILabel.makeTitleLabel()
    let marketingLabel = UILabel.makeSubtitleLabel()
    let percentageLabel = UILabel.makeGrowthLabel()
    let amountLabel = UILabel.makeRegularLabel(weight: .bold)
    let openButton = UIButton(type: .system)
    let popularLabel = UILabel.makeSubtitleLabel(weight: .bold, textColor: .NeoTintColor)
    
    let detailStackView = UIStackView()
    
    lazy var rateStackView: UIStackView = {
        let interestLabel = UILabel.makeSubtitleLabel(text: "Bunga")
        interestLabel.numberOfLines = 0
        
        let stackView = UIStackView(arrangedSubviews: [percentageLabel, interestLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var startingPriceStackView: UIStackView = {
        let startingLabel = UILabel.makeSubtitleLabel(text: "Mulai dari")
        startingLabel.numberOfLines = 0
        
        let stackView = UIStackView(arrangedSubviews: [amountLabel, startingLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        // Setup popularLabel
        popularLabel.text = "Populer"
        popularLabel.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        popularLabel.textColor = .white
        popularLabel.backgroundColor = .NeoOrange
        popularLabel.textAlignment = .center
        popularLabel.layer.cornerRadius = 10
        popularLabel.layer.masksToBounds = true
        popularLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Setup detailStackView
        detailStackView.axis = .horizontal
        detailStackView.alignment = .trailing
        detailStackView.distribution = .equalSpacing
        detailStackView.spacing = 8
        detailStackView.addArrangedSubview(rateStackView)
        detailStackView.addArrangedSubview(startingPriceStackView)
        detailStackView.addArrangedSubview(openButton)
        
        // Setup openButton
        openButton.backgroundColor = .NeoTintColor
        openButton.setTitleColor(.black, for: .normal)
        openButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        openButton.layer.cornerRadius = 10
        openButton.layer.masksToBounds = true
        openButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
        
        // Add subviews
        contentView.addSubview(titleLabel)
        contentView.addSubview(marketingLabel)
        contentView.addSubview(detailStackView)
        contentView.addSubview(popularLabel)
        
        // Layout constraints
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        marketingLabel.translatesAutoresizingMaskIntoConstraints = false
        detailStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            popularLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            popularLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            popularLabel.heightAnchor.constraint(equalToConstant: 20),
            popularLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 50),
            
            marketingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            marketingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            marketingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            detailStackView.topAnchor.constraint(equalTo: marketingLabel.bottomAnchor, constant: 16),
            detailStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            detailStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            detailStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            openButton.heightAnchor.constraint(equalToConstant: 25)
            
        ])
    }

    func configure(with model: NeoProductModel) {
        titleLabel.text = model.productName ?? ""
        marketingLabel.text = model.marketingPoints?.joined(separator: "; ")
        percentageLabel.text = "\(model.rate ?? 0)% p.a"
        amountLabel.text = "Rp. \((model.startingAmount ?? 0).formatNumber())"
        openButton.setTitle("Buka", for: .normal)
        popularLabel.isHidden = !(model.isPopular ?? false)
    }
}
