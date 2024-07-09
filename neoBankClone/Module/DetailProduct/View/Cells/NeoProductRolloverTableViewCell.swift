//
//  NeoProductRolloverTableViewCell.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 07/07/24.
//

import UIKit

protocol NeoProductRolloverTableViewCellDelegate: AnyObject {
    func didTapRightButton(rollover: RolloverSelection, completion: @escaping (String) -> Void)
}

enum RolloverSelection: String, CaseIterable {
    case principal = "Pokok"
    case principalInterest = "Pokok + Bunga"
    case notRollover = "Tidak diperpanjang"
}

class NeoProductRolloverTableViewCell: UITableViewCell {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let optionLabel: UILabel = {
        let label = UILabel.makeRegularLabel()
        label.text = "Opsi Rollover"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rightButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Pokok", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let chevron = UIImage(systemName: "chevron.right")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 10, weight: .regular))
        button.setImage(chevron, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .black
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(didTapRightButton), for: .touchUpInside)
        return button
    }()
    
    weak var parentViewController: UIViewController?
    weak var delegate: NeoProductRolloverTableViewCellDelegate?
    
    var selectedOption: String? {
        didSet {
            rightButton.setTitle(selectedOption, for: .normal)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(optionLabel)
        stackView.addArrangedSubview(rightButton)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    @objc private func didTapRightButton() {
        delegate?.didTapRightButton(rollover: RolloverSelection(rawValue: selectedOption ?? "") ?? .principal) { [weak self] selectedOption in
            self?.selectedOption = selectedOption
        }
    }
}
