import UIKit

protocol NeoProductOpeningTableViewCellDelegate: AnyObject {
    func tncButtonDidTapped()
    func openButtonDidTapped()
    func validateOpenButton(isTncChecked: Bool)
}

class NeoProductOpeningTableViewCell: UITableViewCell {
    
    weak var delegate: NeoProductOpeningTableViewCellDelegate?
    
    private let openButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Buka Sekarang", for: .normal)
        button.setTitleColor(UIColor.NeoTitleColor, for: .normal)
        button.backgroundColor = UIColor.NeoTintColor
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(openButtonDidTap), for: .touchUpInside)
        return button
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
        
        // Set images for normal and selected states
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.setImage(resizedCheckmarkImage(), for: .selected)
        button.tintColor = .systemGray
        
        button.addTarget(self, action: #selector(toggleCheckbox), for: .touchUpInside)
        return button
    }()
    
    private let termsLabel: UILabel = {
        let label = UILabel.makeRegularLabel(fontSize: 10)
        label.text = "Saya telah membaca dan menyetujui"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let readButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("<< Deposito Flexi TnC >>", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.isPointerInteractionEnabled = true
        button.addTarget(self, action: #selector(openWebView), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(openButton)
        contentView.addSubview(checkBoxButton)
        contentView.addSubview(termsLabel)
        contentView.addSubview(readButton)
        
        NSLayoutConstraint.activate([
            openButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            openButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            openButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            openButton.heightAnchor.constraint(equalToConstant: 44),
            
            checkBoxButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            checkBoxButton.centerYAnchor.constraint(equalTo: termsLabel.centerYAnchor),
            checkBoxButton.widthAnchor.constraint(equalToConstant: 18),
            checkBoxButton.heightAnchor.constraint(equalToConstant: 18),
            
            termsLabel.leadingAnchor.constraint(equalTo: checkBoxButton.trailingAnchor, constant: 8),
            termsLabel.topAnchor.constraint(equalTo: openButton.bottomAnchor, constant: 16),
            termsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            readButton.leadingAnchor.constraint(equalTo: termsLabel.trailingAnchor, constant: 4),
            readButton.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),
            readButton.centerYAnchor.constraint(equalTo: termsLabel.centerYAnchor)
        ])
        
        updateCheckboxAppearance()
        setOpenButtonCondition(isEnabled: false)
    }
    
    func updateCheckboxAppearance() {
        let isChecked = checkBoxButton.isSelected
        checkBoxButton.backgroundColor = isChecked ? .systemYellow : .clear
        checkBoxButton.tintColor = isChecked ? .black : .systemGray
        checkBoxButton.layer.borderColor = isChecked ? UIColor.white.cgColor : UIColor.systemGray.cgColor
        
        delegate?.validateOpenButton(isTncChecked: isChecked)
    }
    
    func setOpenButtonCondition(isEnabled: Bool) {
        openButton.isEnabled = isEnabled
        openButton.backgroundColor = isEnabled ? UIColor.NeoTintColor : .gray
        openButton.setTitleColor(isEnabled ? UIColor.NeoTitleColor : .white, for: .normal)
        openButton.alpha = isEnabled ? 1.0 : 0.5
    }
    
    @objc private func toggleCheckbox() {
        checkBoxButton.isSelected.toggle()
        updateCheckboxAppearance()
    }
    
    @objc private func openButtonDidTap() {
        delegate?.openButtonDidTapped()
    }
    
    @objc private func openWebView() {
        delegate?.tncButtonDidTapped()
    }
    
    private func resizedCheckmarkImage() -> UIImage? {
        let image = UIImage(systemName: "checkmark")
        let size = CGSize(width: 10, height: 10)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        image?.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage?.withRenderingMode(.alwaysTemplate)
    }
}
