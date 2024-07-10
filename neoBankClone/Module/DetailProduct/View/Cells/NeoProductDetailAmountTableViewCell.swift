import UIKit

protocol NeoProductDetailAmountTableViewCellProtocol: AnyObject {
    func didAmountOptionSelected()
}

class NeoProductDetailAmountTableViewCell: UITableViewCell {
        
    let label1: UILabel = {
        let label = UILabel.makeTitleLabel()
        label.text = "Masukkan jumlah"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let label2: UILabel = {
        let label = UILabel.makeSubtitleLabel()
        label.text = "Minimum deposito Rp100.000"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let invalidAmountLabel: UILabel = {
        let label = UILabel.makeSubtitleLabel(textColor: .red)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    let label3: UILabel = {
        let label = UILabel.makeSubtitleLabel()
        label.attributedText = createAttributedText(for: "Jatuh Tempo: 28/06/2024", boldText: "28/06/2024")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "100000"
        textField.font = UIFont.systemFont(ofSize: 28)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.isEnabled = true
        textField.isUserInteractionEnabled = true
        textField.keyboardType = .decimalPad
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 66, height: 40))
        let currencyLabel = UILabel(frame: CGRect(x: 16, y: 0, width: 45, height: 40))
        currencyLabel.text = "Rp."
        currencyLabel.font = UIFont.systemFont(ofSize: 28)
        leftView.addSubview(currencyLabel)
        textField.leftView = leftView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8 // 8 points spacing between items
        layout.minimumLineSpacing = 10 // Adjust this value as needed for spacing between rows
        layout.sectionInset = .zero // No inset
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NominalCollectionViewCell.self, forCellWithReuseIdentifier: NominalCollectionViewCell.identifier)
        return collectionView
    }()
    
    // Horizontal StackView for labels on the right
    lazy var rightStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [label2, label3])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // Estimasi bunga labels
    let estimasiBungaLabel: UILabel = {
        let label = UILabel.makeSubtitleLabel(fontSize: 14)
        label.text = "Estimasi bunga"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let estimasiBungaValueLabel: UILabel = {
        let label = UILabel.makeRegularLabel(fontSize: 14, weight: .bold)
        label.text = "Rp. 0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Horizontal StackView for bottom content
    lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [estimasiBungaLabel, UIView(), estimasiBungaValueLabel])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // Divider view
    let dividerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nominalValues = ["1.000.000", "5.000.000", "100.000.000", "500.000.000"]
    private var selectedNominalIndex: IndexPath?
    weak var delegate: NeoProductDetailAmountTableViewCellProtocol?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        textField.resignFirstResponder()
        setupViews()
        addDashedLine(to: dividerView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        contentView.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(label1)
        addSubview(textField)
        addSubview(invalidAmountLabel)
        addSubview(collectionView)
        addSubview(rightStackView)
        addSubview(bottomStackView)
        addSubview(dividerView)
        textField.enableNumberFormatting()
        
        NSLayoutConstraint.activate([
            label1.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            label1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            label1.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            textField.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 10),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 60),
            
            invalidAmountLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 4),
            invalidAmountLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            invalidAmountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            collectionView.topAnchor.constraint(equalTo: invalidAmountLabel.bottomAnchor, constant: 4),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            collectionView.heightAnchor.constraint(equalToConstant: 60),
            
            rightStackView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            rightStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            rightStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            dividerView.topAnchor.constraint(equalTo: rightStackView.bottomAnchor, constant: 10),
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dividerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            
            bottomStackView.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 10),
            bottomStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            bottomStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            bottomStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    private static func createAttributedText(for fullText: String, boldText: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: fullText)
        if let boldRange = fullText.range(of: boldText) {
            let nsRange = NSRange(boldRange, in: fullText)
            attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 12), range: nsRange)
        }
        return attributedString
    }
    
    private func addDashedLine(to view: UIView) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [4, 2]
        
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 0, y: 0), CGPoint(x: view.frame.width, y: 0)])
        shapeLayer.path = path
        
        view.layer.addSublayer(shapeLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let shapeLayer = dividerView.layer.sublayers?.first as? CAShapeLayer {
            let path = CGMutablePath()
            path.addLines(between: [CGPoint(x: 0, y: 0), CGPoint(x: dividerView.frame.width, y: 0)])
            shapeLayer.path = path
        }
    }
    
    @objc private func dismissKeyboard() {
        contentView.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        contentView.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func configure(with model: NeoProductModel, initiateInterest: String) {
        label2.text = "Minimum deposito Rp \(model.startingAmount ?? 0)"
        if let code = model.code, let newDate = addDurationToCurrentDate(code) {
            let formattedDate = formatDate(newDate)
            label3.attributedText = NeoProductDetailAmountTableViewCell.createAttributedText(for: "Jatuh Tempo: \(formattedDate)", boldText: "\(formattedDate)")
        }
        textField.text = "\(model.startingAmount?.formattedWithSeparator() ?? "")"
        textField.placeholder = "\(model.startingAmount?.formattedWithSeparator() ?? "")"
        estimasiBungaValueLabel.text = String(describing: initiateInterest)
        invalidAmountLabel.text = "The amount must be multiple of \(Double(model.startingAmount ?? 0).formattedToRupiah())"
    }
    
    private func formatDate(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: dateString) {
            formatter.dateFormat = "dd/MM/yyyy"
            return formatter.string(from: date)
        }
        return dateString
    }
}

extension NeoProductDetailAmountTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nominalValues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NominalCollectionViewCell.identifier, for: indexPath) as? NominalCollectionViewCell else {
            return UICollectionViewCell()
        }
        let nominalValue = nominalValues[indexPath.row]
        cell.configure(with: nominalValue)
        cell.layer.borderWidth = selectedNominalIndex == indexPath ? 1.25 : 0.25
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedNominalIndex = indexPath
        let selectedValue = nominalValues[indexPath.row].replacingOccurrences(of: ".", with: "")
        if let selectedValue = Int(selectedValue) {
            textField.text = "\(selectedValue.formattedWithSeparator())"
            textField.sendActions(for: .editingDidEnd)
            delegate?.didAmountOptionSelected()
        }
        collectionView.reloadData()
    }
}

extension NeoProductDetailAmountTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let nominalValue = nominalValues[indexPath.row]
        let font = UIFont.systemFont(ofSize: 14)
        let width = nominalValue.size(withAttributes: [.font: font]).width + 20
        return CGSize(width: width, height: 20)
    }
}

extension NeoProductDetailAmountTableViewCell {
    func parseDuration(_ duration: String) -> DateComponents? {
        let unit = duration.suffix(2)
        let valueString = duration.dropLast(2)
        
        guard let value = Int(valueString) else {
            return nil
        }
        
        var components = DateComponents()
        switch unit {
        case "DF":
            components.day = value
        case "MF":
            components.month = value
        case "YF":
            components.year = value
        default:
            return nil
        }
        
        return components
    }

    func addDurationToCurrentDate(_ duration: String) -> Date? {
        guard let components = parseDuration(duration) else {
            return nil
        }
        
        let currentDate = Date()
        let calendar = Calendar.current
        return calendar.date(byAdding: components, to: currentDate)
    }

    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
}
