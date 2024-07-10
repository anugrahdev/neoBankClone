//
//  LandingPageProductListTableViewCell.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 10/07/24.
//

import UIKit

protocol LandingPageProductListTableViewCellProtocol: AnyObject {
    func productDidTapped(with data: NeoProductModel)
}

class LandingPageProductListTableViewCell: UITableViewCell {

    weak var delegate: LandingPageProductListTableViewCellProtocol?
    
    private var displayedProducts: [NeoProductWithType] = []
    private let tableView: DynamicTableView = {
        let tableView = DynamicTableView()
        tableView.register(NeoProductTableViewCell.self, forCellReuseIdentifier: NeoProductTableViewCell.cellIdentifier)
        tableView.register(LandingPageHeaderTableViewCell.self, forCellReuseIdentifier: LandingPageHeaderTableViewCell.cellIdentifier)
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.tableView.invalidateIntrinsicContentSize()
        self.tableView.layoutIfNeeded()
        self.invalidateIntrinsicContentSize()
    }
    
    override var intrinsicContentSize: CGSize {
        let height = tableView.contentSize.height
        return CGSize(width: UIView.noIntrinsicMetric, height: height)
    }
    
    private func setupView() {
        contentView.addSubview(tableView)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.layer.borderWidth = 0.5
        tableView.layer.borderColor = UIColor.lightGray.cgColor
        tableView.layer.cornerRadius = 10
                
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with data: [NeoProductWithType]) {
        self.displayedProducts = data
        self.tableView.reloadData()
        self.tableView.layoutIfNeeded()
    }

}

extension LandingPageProductListTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedProducts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = displayedProducts[indexPath.row].product else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: NeoProductTableViewCell.cellIdentifier, for: indexPath) as! NeoProductTableViewCell
        cell.configure(with: data)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data = displayedProducts[indexPath.row].product else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.productDidTapped(with: data)
    }
}
