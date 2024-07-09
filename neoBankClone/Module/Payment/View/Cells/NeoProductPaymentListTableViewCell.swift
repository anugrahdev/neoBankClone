//
//  NeoProductPaymentListTableViewCell.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 09/07/24.
//

import UIKit

protocol NeoProductPaymentListTableViewCellDelegate: AnyObject {
    func didToggleExpansion(cell: NeoProductPaymentListTableViewCell)
}

class NeoProductPaymentListTableViewCell: UITableViewCell {
    
    weak var delegate: NeoProductPaymentListTableViewCellDelegate?
    private var isExpanded: Bool = false
    private var channels: [Channel] = []

    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.clear.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "payment")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel.makeTitleLabel(fontSize: 16, weight: .bold)
        label.text = "Virtual Account"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let toggleButton: UIButton = {
        let button = UIButton(type: .system)
        let chevronDown = UIImage(systemName: "chevron.down")
        button.setImage(chevronDown, for: .normal)
        button.addTarget(self, action: #selector(toggleButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.NeoSubtitleColor
        return button
    }()
    
    private let tableView: DynamicTableView = {
        let tableView = DynamicTableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "InnerCell")
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var tableViewHeightConstraint: NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(containerView)
        
        let stackView = UIStackView(arrangedSubviews: [iconImageView, titleLabel, toggleButton])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(stackView)
        containerView.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(NeoProductPaymentMethodTableViewCell.self, forCellReuseIdentifier: "NeoProductPaymentMethodTableViewCell")
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleButtonTapped))
        contentView.addGestureRecognizer(tapGestureRecognizer)
        contentView.backgroundColor = .NeoGreyolor
        
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            toggleButton.widthAnchor.constraint(equalToConstant: 24),
            toggleButton.heightAnchor.constraint(equalToConstant: 24),
            
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
        ])
        
        tableViewHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: 0)
        tableViewHeightConstraint?.isActive = true
    }
    
    private func createInstructionHeaderView() -> UIView {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        
        let label = UILabel.makeSubtitleLabel()
        label.text = "Kamu bisa bayar dengan kode virtual account dari salah satu bank dibawah. Jika nominal pembayaran lebih besar dari limit transfer satu kali bank yang dipilih, kamu dapat melakukan beberapa kali top up saldo ke rekening Tabungan Reguler atau rekening Tabungan NOW kamu dan melanjutkan pembayaran menggunakan saldomu setelahnya."
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -8),
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8)
        ])
        
        let labelWidth = contentView.frame.width - 32
        let labelSize = label.sizeThatFits(CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude))
        headerView.frame = CGRect(x: 0, y: 0, width: labelWidth, height: labelSize.height + 16)
        
        return headerView
    }
    
    @objc private func toggleButtonTapped() {
        isExpanded.toggle()
        
        UIView.performWithoutAnimation {
            tableView.isHidden = !isExpanded
            updateTableViewHeight()
            
            let chevron = isExpanded ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down")
            toggleButton.setImage(chevron, for: .normal)
            
            if isExpanded {
                tableView.tableHeaderView = createInstructionHeaderView()
            } else {
                tableView.tableHeaderView = nil
            }
            
            delegate?.didToggleExpansion(cell: self)
            
            layoutIfNeeded()
        }
    }

    private func updateTableViewHeight() {
        guard isExpanded else {
            tableViewHeightConstraint?.constant = 0
            return
        }
        
        let headerHeight = createInstructionHeaderView().frame.height
        
        let numberOfRows = tableView.numberOfRows(inSection: 0)
        let rowHeight = tableView.rowHeight > 0 ? tableView.rowHeight : 44
        let totalRowsHeight = CGFloat(numberOfRows) * rowHeight
        
        tableViewHeightConstraint?.constant = headerHeight + totalRowsHeight
    }
    
    func configure(with data: PaymentMethod) {
        self.titleLabel.text = data.paymentMethod
        self.channels = data.channels
        tableView.reloadData()
    }
}

extension NeoProductPaymentListTableViewCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NeoProductPaymentMethodTableViewCell", for: indexPath) as! NeoProductPaymentMethodTableViewCell
        cell.configure(with: channels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
