//
//  ProductPaymentViewController.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 08/07/24.
//

import UIKit


class ProductPaymentViewController: UIViewController, ProductPaymentViewControllerProtocol {

    var presenter: ProductPaymentPresenterProtocol?
    private var paymentListData: [PaymentMethod] = []
    private var countdownTimer: Timer?
    private var endTime: Date?
    private var paymentData: NeoProductDetailSelectionModel?

    let sections: [ProductPaymentSection] = ProductPaymentSection.allCases
    enum ProductPaymentSection: String, CaseIterable {
        case header = "header"
        case virtualAccount = "virtualAccount"
    }
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "payment-bg")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let timerLabel: UILabel = {
        let label = UILabel.makeSubtitleLabel(textColor: UIColor.NeoBrownColor)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Berakhir dalam 23:59:00"
        label.textAlignment = .center
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.NeoBrownColor.cgColor
        label.layer.cornerRadius = 15
        label.clipsToBounds = true
        return label
    }()
    
    let amountLabel: UILabel = {
        let label = UILabel.makeTitleLabel(fontSize: 26, weight: .bold, textColor: UIColor.NeoBrownColor)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Rp. 100.000"
        label.textAlignment = .center
        return label
    }()
    
    let secureTransactionLabel: UILabel = {
        let label = UILabel.makeRegularLabel(weight: .semibold, textColor: UIColor.NeoBrownColor)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Transaksimu aman dan terjaga"
        label.textAlignment = .center
        return label
    }()
    
    let secureTransactionIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "checkmark.shield.fill")
        imageView.tintColor = .NeoBrownColor
        return imageView
    }()
    
    private let tableView: DynamicTableView = {
        let tableView = DynamicTableView()
        tableView.register(NeoProductPaymentHeaderTableViewCell.self, forCellReuseIdentifier: "NeoProductPaymentHeaderTableViewCell")
        tableView.register(NeoProductPaymentListTableViewCell.self, forCellReuseIdentifier: "NeoProductPaymentListTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.applyTheme()
        removeBackButtonText()
        presenter?.getPaymentData()
        setupUI()
    }
    
    private func setupUI() {
        setNavigationBarTitle(title: "Payment", isCentered: true)
        
        view.addSubview(backgroundImageView)
        backgroundImageView.addSubview(containerView)
        containerView.addSubview(timerLabel)
        containerView.addSubview(amountLabel)
        containerView.addSubview(secureTransactionIcon)
        containerView.addSubview(secureTransactionLabel)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 150),
            
            containerView.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: backgroundImageView.centerYAnchor),
            
            timerLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            timerLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            timerLabel.heightAnchor.constraint(equalToConstant: 30),
            timerLabel.widthAnchor.constraint(equalToConstant: timerLabel.intrinsicContentSize.width + 16),
            
            amountLabel.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 10),
            amountLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            amountLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            secureTransactionIcon.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 10),
            secureTransactionIcon.trailingAnchor.constraint(equalTo: secureTransactionLabel.leadingAnchor, constant: -5),
            secureTransactionIcon.centerYAnchor.constraint(equalTo: secureTransactionLabel.centerYAnchor),
            secureTransactionIcon.widthAnchor.constraint(equalToConstant: 14),
            secureTransactionIcon.heightAnchor.constraint(equalToConstant: 14),
            
            secureTransactionLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 10),
            secureTransactionLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        startCountdown()
        
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
            tableView.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 16)
        ])
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    private func startCountdown() {
        endTime = Date().addingTimeInterval(24 * 60 * 60) // 24 hours from now
        if countdownTimer == nil {
            countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            RunLoop.current.add(countdownTimer!, forMode: .common)
        }
    }
    
    private func stopCountdown() {
        countdownTimer?.invalidate()
        countdownTimer = nil
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopCountdown()
    }
    
    @objc private func updateTimer() {
        guard let endTime = endTime else { return }
        
        let currentTime = Date()
        let timeInterval = endTime.timeIntervalSince(currentTime)
        
        if timeInterval <= 0 {
            countdownTimer?.invalidate()
            countdownTimer = nil
            timerLabel.text = "Berakhir dalam 00:00:00"
        } else {
            let hours = Int(timeInterval) / 3600
            let minutes = Int(timeInterval) % 3600 / 60
            let seconds = Int(timeInterval) % 60
            timerLabel.text = String(format: "Berakhir dalam %02d:%02d:%02d", hours, minutes, seconds)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        countdownTimer?.invalidate()
        countdownTimer = nil
        startCountdown()
    }
    
    func setProductPaymentData(with data: NeoProductDetailSelectionModel) {
        amountLabel.text = data.amount.formattedToRupiah()
    }
    
    func setPaymentListData(with data: PaymentDataModel) {
        paymentListData = data.data
        tableView.reloadData()
    }
    
}
extension ProductPaymentViewController: UITableViewDelegate, UITableViewDataSource, NeoProductPaymentListTableViewCellDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return paymentListData.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        
        switch section {
        case .header:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NeoProductPaymentHeaderTableViewCell", for: indexPath) as! NeoProductPaymentHeaderTableViewCell
            return cell
        case .virtualAccount:
            let payment = paymentListData[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "NeoProductPaymentListTableViewCell", for: indexPath) as! NeoProductPaymentListTableViewCell
            cell.configure(with: payment, indexPath: indexPath)
            cell.delegate = self
            return cell
        }
    }
    
    func didToggleExpansion(cell: NeoProductPaymentListTableViewCell) {
        guard tableView.indexPath(for: cell) != nil else { return }
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
}
