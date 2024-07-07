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

    var interactor: LandingPageInteractorLogic?

    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Wealth"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel.makeTitleLabel()
        label.text = "Fleksibel"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let segmentedControl: UISegmentedControl = {
        let items = ["Fleksibel", "Bunga Tetap"]
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
        tableView.register(NeoProductTableViewCell.self, forCellReuseIdentifier: "NeoProductTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        return tableView
    }()

    private var allProducts: [NeoProductWithType] = []
    private var displayedProducts: [NeoProductWithType] = []
    private var yellowUnderline: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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
        view.addSubview(headerLabel)
        view.addSubview(titleLabel)
        view.addSubview(segmentedControl)
        view.addSubview(tableView)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.borderWidth = 0.5
        tableView.layer.borderColor = UIColor.lightGray.cgColor
        tableView.layer.cornerRadius = 10
        tableView.clipsToBounds = true

        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            segmentedControl.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            segmentedControl.heightAnchor.constraint(equalToConstant: 30),

            titleLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
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
        titleLabel.text = segmentedControl.selectedSegmentIndex == 0 ? "Flexible" : "Fixed Income"
        yellowUnderline.frame = CGRect(x: leadingDistance, y: segmentedControl.bounds.height - 2, width: underlineWidth, height: 2)
    }

    private func fetchProducts() {
        interactor?.getLandingData()
    }

    @objc private func segmentedControlChanged() {
        updateUnderlinePosition()
        filterProducts()
    }

    private func filterProducts() {
        let selectedSegment = segmentedControl.selectedSegmentIndex == 0 ? "Flexible" : "Fixed Income"
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
        }
    }
}

extension LandingPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedProducts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = displayedProducts[indexPath.row].product else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "NeoProductTableViewCell", for: indexPath) as! NeoProductTableViewCell
        cell.configure(with: data)
        return cell
    }
}
