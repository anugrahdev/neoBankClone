//
//  BottomSheetOptionTableViewCell.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 08/07/24.
//

import UIKit

class BottomSheetOptionTableViewCell: UITableViewCell {

    private let titleLabel: UILabel = {
        let label = UILabel.makeRegularLabel(weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel.makeSubtitleLabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let termsLabel: UILabel = {
        let label = UILabel.makeSubtitleLabel()
        label.numberOfLines = 0
        label.font = UIFont.italicSystemFont(ofSize: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var checkBoxButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.isPointerInteractionEnabled = true
        button.isEnabled = true
        button.layer.cornerRadius = 9
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.setImage(resizedCheckmarkImage(), for: .selected)
        button.tintColor = .systemGray
        
        button.addTarget(self, action: #selector(toggleCheckbox), for: .touchUpInside)
        return button
    }()
    
    private func resizedCheckmarkImage() -> UIImage? {
        let image = UIImage(systemName: "checkmark")
        let size = CGSize(width: 10, height: 10)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        image?.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage?.withRenderingMode(.alwaysTemplate)
    }

    var checkBoxTapped: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(termsLabel)
        contentView.addSubview(checkBoxButton)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: checkBoxButton.leadingAnchor, constant: -8),
            
            checkBoxButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            checkBoxButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            checkBoxButton.widthAnchor.constraint(equalToConstant: 18),
            checkBoxButton.heightAnchor.constraint(equalToConstant: 18),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            termsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4),
            termsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            termsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            termsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])

        checkBoxButton.addTarget(self, action: #selector(didTapCheckBox), for: .touchUpInside)
    }

    @objc private func didTapCheckBox() {
        checkBoxTapped?()
    }

    func configure(with option: (String, String, String), isSelected: Bool) {
        titleLabel.text = option.0
        descriptionLabel.text = option.1
        termsLabel.text = option.2
        checkBoxButton.isSelected = isSelected
        updateCheckboxAppearance()
    }
    
    @objc private func toggleCheckbox() {
        checkBoxButton.isSelected.toggle()
        updateCheckboxAppearance()
    }
    
    private func updateCheckboxAppearance() {
        let isChecked = checkBoxButton.isSelected
        checkBoxButton.backgroundColor = isChecked ? .systemYellow : .clear
        checkBoxButton.tintColor = isChecked ? .black : .systemGray
        checkBoxButton.layer.borderColor = isChecked ? UIColor.white.cgColor : UIColor.systemGray.cgColor
    }
}
