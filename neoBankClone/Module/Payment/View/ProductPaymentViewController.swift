//
//  ProductPaymentViewController.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 08/07/24.
//

import UIKit

class ProductPaymentViewController: UIViewController {
    
    var router: ProductPaymentRouterLogic?

    let sections: [ProductPaymentSection] = ProductPaymentSection.allCases
    enum ProductPaymentSection: String, CaseIterable {
        case header = "header"
    }
    
    private let tableView: DynamicTableView = {
        let tableView = DynamicTableView()
        tableView.register(NeoProductPaymentHeaderTableViewCell.self, forCellReuseIdentifier: "NeoProductPaymentHeaderTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.applyTheme()
        setupUI()
    }
    
    private func setupUI() {
        setNavigationBarTitle(title: "Payment", isCentered: true)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.clipsToBounds = true
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor.NeoGreyolor
        tableView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.tableView.addGestureRecognizer(tapGesture)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 16)
        ])
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }

}

extension ProductPaymentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        
        switch section {
        case .header:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NeoProductPaymentHeaderTableViewCell", for: indexPath) as! NeoProductPaymentHeaderTableViewCell
            return cell
        }
    }
}
