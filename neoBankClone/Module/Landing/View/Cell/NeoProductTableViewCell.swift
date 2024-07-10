import UIKit

protocol NeoProductTableViewCellDelegate: AnyObject {
    func openButtonDidTap(in cell: NeoProductTableViewCell)
}

class NeoProductTableViewCell: UITableViewCell {
    
    weak var delegate: NeoProductTableViewCellDelegate?
    
    lazy var titleLabel: UILabel = {
        return UILabel.makeTitleLabel()
    }()
    
    lazy var marketingLabel: UILabel = {
        return UILabel.makeSubtitleLabel()
    }()
    
    lazy var percentageLabel: UILabel = {
        return UILabel.makeGrowthLabel()
    }()
    
    lazy var amountLabel: UILabel = {
        return UILabel.makeRegularLabel(weight: .bold)
    }()
    
    lazy var openButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .NeoTintColor
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
        button.isUserInteractionEnabled = false
        return button
    }()
    
    lazy var popularLabel: UILabel = {
        let label = UILabel.makeSubtitleLabel(weight: .bold, textColor: .NeoTintColor)
        label.text = StringResources.populer
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        label.textColor = .white
        label.backgroundColor = .NeoOrange
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        return label
    }()
    
    lazy var detailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .trailing
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        stackView.addArrangedSubview(rateStackView)
        stackView.addArrangedSubview(startingPriceStackView)
        stackView.addArrangedSubview(openButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var rateStackView: UIStackView = {
        let interestLabel = UILabel.makeSubtitleLabel(text: "Bunga")
        interestLabel.numberOfLines = 0
        
        let stackView = UIStackView(arrangedSubviews: [percentageLabel, interestLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var startingPriceStackView: UIStackView = {
        let startingLabel = UILabel.makeSubtitleLabel(text: "Mulai dari")
        startingLabel.numberOfLines = 0
        
        let stackView = UIStackView(arrangedSubviews: [amountLabel, startingLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(marketingLabel)
        contentView.addSubview(detailStackView)
        contentView.addSubview(popularLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        marketingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            popularLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            popularLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            popularLabel.heightAnchor.constraint(equalToConstant: 20),
            popularLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 50),
            
            marketingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            marketingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            marketingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            detailStackView.topAnchor.constraint(equalTo: marketingLabel.bottomAnchor, constant: 16),
            detailStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            detailStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            detailStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            openButton.heightAnchor.constraint(equalToConstant: 25)
        ])
    }

    func configure(with model: NeoProductModel) {
        titleLabel.text = model.productName ?? ""
        marketingLabel.text = model.marketingPoints?.joined(separator: "; ")
        percentageLabel.text = "\(model.rate ?? 0)% p.a"
        amountLabel.text = "Rp. \((model.startingAmount ?? 0).formatNumber())"
        openButton.setTitle(StringResources.open, for: .normal)
        popularLabel.isHidden = !(model.isPopular ?? false)
    }
    
}
