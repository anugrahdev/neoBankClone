//
//  LandingPageViewController.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 06/07/24.
//

import UIKit

protocol LandingPageViewControllerLogic: AnyObject {
    func presentLandingData(products: [NeoProductWithType])
}

class LandingPageViewController: UIViewController {

    var presenter: LandingPagePresenterProtocol?

    enum LandingSections: String, CaseIterable {
        case header = "header"
        case products = "products"
    }
    
    enum productType: String {
        case flexible = "Flexible"
        case fixed = "Fixed Income"
    }
    
    let sections: [LandingSections] = LandingSections.allCases
    var currentProductTypeSelected = ""
    
    private let segmentedControl: UISegmentedControl = {
        let items = [StringResources.flexible, StringResources.fixedIncome]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .clear
        segmentedControl.tintColor = .clear

        let clearImage = UIImage()
        segmentedControl.setBackgroundImage(clearImage, for: .normal, barMetrics: .default)
        segmentedControl.setBackgroundImage(clearImage, for: .selected, barMetrics: .default)
        segmentedControl.setDividerImage(clearImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)

        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 14)
        ]

        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: 14)
        ]

        segmentedControl.setTitleTextAttributes(normalAttributes, for: .normal)
        segmentedControl.setTitleTextAttributes(selectedAttributes, for: .selected)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false

        return segmentedControl
    }()

    private let tableView: DynamicTableView = {
        let tableView = DynamicTableView()
        tableView.register(LandingPageHeaderTableViewCell.self, forCellReuseIdentifier: LandingPageHeaderTableViewCell.cellIdentifier)
        tableView.register(LandingPageProductListTableViewCell.self, forCellReuseIdentifier: LandingPageProductListTableViewCell.cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        return tableView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    private var allProducts: [NeoProductWithType] = []
    private var displayedProducts: [NeoProductWithType] = []
    private var yellowUnderline: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.applyTheme()
        setupUI()
        setupSegmentedControlUnderline()
        fetchProducts()

        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged), for: .valueChanged)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateUnderlinePosition()
    }

    private func setupUI() {
        setNavigationBarTitle(title: "Wealth", isCentered: false)

        view.addSubview(segmentedControl)
        view.addSubview(tableView)
        view.addSubview(activityIndicator)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.clipsToBounds = true
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false

        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            segmentedControl.heightAnchor.constraint(equalToConstant: 30),

            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func setupSegmentedControlUnderline() {
        yellowUnderline = UIView()
        yellowUnderline.backgroundColor = .systemYellow
        yellowUnderline.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addSubview(yellowUnderline)

        updateUnderlinePosition()
    }

    private func updateUnderlinePosition() {
        let selectedSegmentIndex = segmentedControl.selectedSegmentIndex
        let segmentWidth = segmentedControl.bounds.width / CGFloat(segmentedControl.numberOfSegments)
        let underlineWidth: CGFloat = 20
        let leadingDistance = segmentWidth * CGFloat(selectedSegmentIndex) + (segmentWidth - underlineWidth) / 2
        currentProductTypeSelected = segmentedControl.selectedSegmentIndex == 0 ? productType.flexible.rawValue : productType.fixed.rawValue
        yellowUnderline.frame = CGRect(x: leadingDistance, y: segmentedControl.bounds.height - 2, width: underlineWidth, height: 2)
    }

    private func fetchProducts() {
        activityIndicator.startAnimating()
        presenter?.getLandingData()
    }

    @objc private func segmentedControlChanged() {
        updateUnderlinePosition()
        filterProducts()
    }

    private func filterProducts() {
        let selectedSegment = segmentedControl.selectedSegmentIndex == 0 ? productType.flexible.rawValue : productType.fixed.rawValue
        displayedProducts = allProducts.filter { $0.type == selectedSegment }

        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.updateTableViewHeight()
        }
    }

    private func updateTableViewHeight() {
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
}

extension LandingPageViewController: LandingPageViewControllerLogic {
    func presentLandingData(products: [NeoProductWithType]) {
        DispatchQueue.main.async { [weak self] in
            self?.allProducts = products
            self?.filterProducts()
            self?.activityIndicator.stopAnimating()
            self?.tableView.reloadData()
            self?.view.setNeedsLayout()
            self?.view.layoutIfNeeded()
        }
    }
}

extension LandingPageViewController: UITableViewDelegate, UITableViewDataSource, LandingPageProductListTableViewCellProtocol {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        
        switch section {
        case .header:
            let cell = tableView.dequeueReusableCell(withIdentifier: LandingPageHeaderTableViewCell.cellIdentifier, for: indexPath) as! LandingPageHeaderTableViewCell
            cell.configure(with: currentProductTypeSelected)
            return cell
        case .products:
            let cell = tableView.dequeueReusableCell(withIdentifier: LandingPageProductListTableViewCell.cellIdentifier, for: indexPath) as! LandingPageProductListTableViewCell
            cell.configure(with: displayedProducts)
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
        }
    }
    
    func productDidTapped(with data: NeoProductModel) {
        presenter?.presentDetailData(products: data)
    }
    
}
