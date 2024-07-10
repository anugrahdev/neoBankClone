//
//  NeoProductDetailViewController.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 07/07/24.
//

import UIKit
import WebKit

class ProductDetailViewController: UIViewController, ProductDetailPageViewControllerProtocol {
    
    var presenter: ProductDetailPagePresenterProtocol?
    let sections: [ProductDetailSection] = ProductDetailSection.allCases
    var isTncChecked = false
    var product: NeoProductModel?
    private let halfScreenTransitionDelegate = HalfScreenTransitionDelegate()
    private var webView: WKWebView?

    enum ProductDetailSection: String, CaseIterable {
        case header = "header"
        case amount = "amount"
        case rollover = "rollover"
        case button = "button"
    }
    
    private let tableView: DynamicTableView = {
        let tableView = DynamicTableView()
        tableView.register(NeoProductDetailHeaderTableViewCell.self, forCellReuseIdentifier: "NeoProductDetailHeaderTableViewCell")
        tableView.register(NeoProductDetailAmountTableViewCell.self, forCellReuseIdentifier: "NeoProductDetailAmountTableViewCell")
        tableView.register(NeoProductRolloverTableViewCell.self, forCellReuseIdentifier: "NeoProductRolloverTableViewCell")
        tableView.register(NeoProductOpeningTableViewCell.self, forCellReuseIdentifier: "NeoProductOpeningTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.applyTheme()
        presenter?.didLoad()
        setupUI()
    }
    
    private func setupUI() {
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

extension ProductDetailViewController: UITableViewDelegate, UITableViewDataSource {
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "NeoProductDetailHeaderTableViewCell", for: indexPath) as! NeoProductDetailHeaderTableViewCell
            if let product = product {
                cell.configure(with: product)
            }
            return cell
        case .amount:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NeoProductDetailAmountTableViewCell", for: indexPath) as! NeoProductDetailAmountTableViewCell
            cell.textField.delegate = self
            cell.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            if let product = product, let inputAmount = product.startingAmount, let rate = product.rate, let code = product.code {
                let initiateInterestCalculation = calculateInterestAmount(amount: Decimal(inputAmount), periodCode: code, annualInterestRate: Double(rate))
                cell.configure(with: product, initiateInterest: initiateInterestCalculation.formattedToRupiah() ?? "")
            }
            cell.contentView.isUserInteractionEnabled = false
            cell.delegate = self
            return cell
        case .rollover:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NeoProductRolloverTableViewCell", for: indexPath) as! NeoProductRolloverTableViewCell
            cell.delegate = self
            return cell
        case .button:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NeoProductOpeningTableViewCell", for: indexPath) as! NeoProductOpeningTableViewCell
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return CustomCellSeparatorView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
}

extension ProductDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text = textField.text {
            processInput(text)
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        amountValidChecker(textField: textField)
    }
    
    private func amountValidChecker(textField: UITextField) {
        guard let text = textField.text?.replacingOccurrences(of: ".", with: ""), let amount = Double(text) else {
            textField.setBorderValid(false)
            return
        }
        
        if amount.truncatingRemainder(dividingBy: Double(product?.startingAmount ?? 0)) != 0 {
            let openingCell = tableView.cellForRow(at: IndexPath(row: 0, section: sections.firstIndex(where: { $0 == .button }) ?? 0)) as? NeoProductOpeningTableViewCell
            let amountCell = tableView.cellForRow(at: IndexPath(row: 0, section: sections.firstIndex(where: { $0 == .amount }) ?? 0)) as? NeoProductDetailAmountTableViewCell
            openingCell?.setOpenButtonCondition(isEnabled: false)
            textField.setBorderValid(false)
            amountCell?.invalidAmountLabel.isHidden = false
        } else {
            let openingCell = tableView.cellForRow(at: IndexPath(row: 0, section: sections.firstIndex(where: { $0 == .button }) ?? 0)) as? NeoProductOpeningTableViewCell
            let amountCell = tableView.cellForRow(at: IndexPath(row: 0, section: sections.firstIndex(where: { $0 == .amount }) ?? 0)) as? NeoProductDetailAmountTableViewCell
            openingCell?.setOpenButtonCondition(isEnabled: isTncChecked)
            textField.setBorderValid(true)
            amountCell?.invalidAmountLabel.isHidden = true
        }
    }
    
    func processInput(_ input: String) {
        guard let inputAmount = Double(input.replacingOccurrences(of: ".", with: "")),
                let rate = product?.rate,
                let code = product?.code,
                let amountCell = tableView.cellForRow(at: IndexPath(row: 0, section: sections.firstIndex(where: { $0 == .amount }) ?? 0)) as? NeoProductDetailAmountTableViewCell
        else { return }
        
        let interest = calculateInterestAmount(amount: Decimal(inputAmount), periodCode: code, annualInterestRate: Double(rate))
        amountCell.estimasiBungaValueLabel.text = interest.formattedToRupiah()
    }
    
    func calculateInterestAmount(amount: Decimal, periodCode: String, annualInterestRate: Double) -> Decimal {
        let period = Decimal(string: String(periodCode.dropLast(2))) ?? Decimal(0.0)
        let code = periodCode.dropLast(1)
        var interest: Decimal = 0.0
        var interestAmount: Decimal = 0.0
        
        if code.hasSuffix("D") {
            interest = Decimal(annualInterestRate / 100.0 / 365.0)
            interestAmount = (interest * period) * amount
        } else if code.hasSuffix("M") {
            interest = Decimal(annualInterestRate / 100.0 / 12.0)
            interestAmount = (interest * period) * amount
        } else if code.hasSuffix("Y") {
            interest = Decimal(annualInterestRate / 100.0)
            interestAmount = interest * amount
        }
        
        return interestAmount
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
       if let text = textField.text {
           processInput(text)
       }
   }
}

extension ProductDetailViewController: NeoProductRolloverTableViewCellDelegate, NeoProductOpeningTableViewCellDelegate, NeoProductDetailAmountTableViewCellProtocol {
    func validateOpenButton(isTncChecked: Bool) {
        self.isTncChecked = isTncChecked
        let amountCell = tableView.cellForRow(at: IndexPath(row: 0, section: sections.firstIndex(where: { $0 == .amount }) ?? 0)) as? NeoProductDetailAmountTableViewCell
        let openingCell = tableView.cellForRow(at: IndexPath(row: 0, section: sections.firstIndex(where: { $0 == .button }) ?? 0)) as? NeoProductOpeningTableViewCell
        _ = Double(amountCell?.textField.text ?? "0")
        let isValid = amountCell?.textField.layer.borderWidth == 0
        openingCell?.setOpenButtonCondition(isEnabled: isValid && isTncChecked)
    }
    
    func openButtonDidTapped() {
        let amountCell = tableView.cellForRow(at: IndexPath(row: 0, section: sections.firstIndex(where: { $0 == .amount }) ?? 0)) as? NeoProductDetailAmountTableViewCell
        if let amount = amountCell?.textField.text?.replacingOccurrences(of: ".", with: "") {
            let data = NeoProductDetailSelectionModel(amount: Double(amount) ?? 0)
            presenter?.presentPaymentPage(with: data)
        }
    }

    func tncButtonDidTapped() {
        guard let url = URL(string: AppConstants.neoBankURL) else {
            return
        }
        
        let config = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: config)
        
        if let webView = webView {
            let viewController = UIViewController()
            viewController.view = webView
            webView.load(URLRequest(url: url))
            self.present(viewController, animated: true)
        }
    }
    
    func didTapRightButton(rollover: RolloverSelection, completion: @escaping (String) -> Void) {
        let bottomSheetVC = RolloverPopupModalViewController()
        bottomSheetVC.selectedOption = rollover.rawValue
        bottomSheetVC.selectionHandler = { selectedOption in
            completion(selectedOption)
        }
        bottomSheetVC.modalPresentationStyle = .custom
        bottomSheetVC.transitioningDelegate = halfScreenTransitionDelegate
        present(bottomSheetVC, animated: true, completion: nil)
    }
    
    func didAmountOptionSelected() {
        let amountCell = tableView.cellForRow(at: IndexPath(row: 0, section: sections.firstIndex(where: { $0 == .amount }) ?? 0)) as? NeoProductDetailAmountTableViewCell
        if let textField = amountCell?.textField {
            amountValidChecker(textField: textField)
            processInput(textField.text ?? "0")
        }
    }
}
