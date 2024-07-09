//
//  ProductPaymentHeaderTableViewCell.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 09/07/24.
//

import UIKit

class NeoProductPaymentHeaderTableViewCell: UITableViewCell {
    
    // Container View
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .NeoGreyolor
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    // Background Image View
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "payment-method-bg")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // Payment Method Label
    private let paymentMethodLabel: UILabel = {
        let label = UILabel.makeSubtitleLabel()
        label.text = "Metode Pembayaran"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    // Recommendation Label
    private let recommendationLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.text = "Rekomendasi"
        label.textColor = .orange
        label.font = UIFont.systemFont(ofSize: 10, weight: .light)
        label.textAlignment = .center
        label.backgroundColor = UIColor(rgb: 0xfcf8d7)
        label.layer.cornerRadius = 4
        label.layer.borderWidth = 1
        label.layer.masksToBounds = true
        label.layer.borderColor = UIColor.systemYellow.cgColor
        label.textInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        return label
    }()
    
    // Regular Savings Label
    private let regularSavingsLabel: UILabel = {
        let label = UILabel.makeTitleLabel()
        label.text = "Tabungan Reguler (4952)"
        return label
    }()
    
    // Active Balance Label
    private let activeBalanceLabel: UILabel = {
        let label = UILabel.makeSubtitleLabel()
        label.text = "Saldo Aktif : Rp150.000,01"
        return label
    }()
    
    // Pay Button
    private let payButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Bayar", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .NeoTintColor
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        // Adding subviews
        contentView.backgroundColor = .NeoGreyolor
        contentView.addSubview(containerView)
        containerView.addSubview(backgroundImageView)
        containerView.addSubview(paymentMethodLabel)
        containerView.addSubview(recommendationLabel)
        containerView.addSubview(regularSavingsLabel)
        containerView.addSubview(activeBalanceLabel)
        containerView.addSubview(payButton)
        
        // Setting up constraints
        containerView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        paymentMethodLabel.translatesAutoresizingMaskIntoConstraints = false
        recommendationLabel.translatesAutoresizingMaskIntoConstraints = false
        regularSavingsLabel.translatesAutoresizingMaskIntoConstraints = false
        activeBalanceLabel.translatesAutoresizingMaskIntoConstraints = false
        payButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Container View
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            containerView.heightAnchor.constraint(equalToConstant: 100), // Ensure containerView has a height
            
            // Background Image View
            backgroundImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 100),
            
            // Payment Method Label
            paymentMethodLabel.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: 10),
            paymentMethodLabel.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor, constant: 10),
            
            // Recommendation Label
            recommendationLabel.centerYAnchor.constraint(equalTo: paymentMethodLabel.centerYAnchor),
            recommendationLabel.leadingAnchor.constraint(equalTo: paymentMethodLabel.trailingAnchor, constant: 10),
            
            // Regular Savings Label
            regularSavingsLabel.topAnchor.constraint(equalTo: paymentMethodLabel.bottomAnchor, constant: 10),
            regularSavingsLabel.leadingAnchor.constraint(equalTo: paymentMethodLabel.leadingAnchor),
            
            // Active Balance Label
            activeBalanceLabel.topAnchor.constraint(equalTo: regularSavingsLabel.bottomAnchor, constant: 10),
            activeBalanceLabel.leadingAnchor.constraint(equalTo: regularSavingsLabel.leadingAnchor),
            
            // Pay Button
            payButton.topAnchor.constraint(equalTo: regularSavingsLabel.topAnchor, constant: 8),
            payButton.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor, constant: -10),
            payButton.widthAnchor.constraint(equalToConstant: 80),
            payButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
