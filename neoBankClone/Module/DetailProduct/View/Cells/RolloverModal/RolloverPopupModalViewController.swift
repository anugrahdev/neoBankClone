//
//  RolloverPopupModalViewController.swift
//  neoBankClone
//
//  Created by Anang Nugraha on 08/07/24.
//

import UIKit

class RolloverPopupModalViewController: UIViewController {

    var options = [
        ("Pokok", "Bunga dikirim ke saldo aktif setelah jatuh tempo. Nilai pokok otomatis diperpanjang dengan jangka waktu deposito yang sama.", "Suku bunga saat ini akan dihitung berdasarkan \"suku bunga dasar + suku bunga tambahan\" dan suku bunga saat roll-over akan dihitung berdasarkan suku bunga yang berlaku di tanggal roll-over."),
        ("Pokok + Bunga", "Nilai pokok + bunga otomatis diperpanjang dengan jangka waktu deposito yang sama.", "Suku bunga saat ini akan dihitung berdasarkan \"suku bunga dasar + suku bunga tambahan\" dan suku bunga saat roll-over akan dihitung berdasarkan suku bunga yang berlaku di tanggal roll-over."),
        ("Tidak diperpanjang", "Nilai pokok & bunga otomatis masuk ke saldo aktif setelah lewat jatuh tempo.", "")
    ]

    var selectedOption: String? = "Pokok"
    var selectionHandler: ((String) -> Void)?

    private let titleLabel: UILabel = {
        let label = UILabel.makeTitleLabel()
        label.text = "Opsi Rollover"
        label.textAlignment = .center
        return label
    }()

    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("X", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        return button
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(BottomSheetOptionTableViewCell.self, forCellReuseIdentifier: "BottomSheetOptionTableViewCell")
        tableView.tableFooterView = UIView()
        return tableView
    }()

    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBackgroundView()
        setupLayout()
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setupBackgroundView() {
        guard let parentView = view.superview else { return }
        backgroundView.frame = parentView.bounds
        parentView.addSubview(backgroundView)
        parentView.bringSubviewToFront(view)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleOutsideTap(_:)))
        backgroundView.addGestureRecognizer(tapGesture)
    }

    private func setupLayout() {
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.clipsToBounds = true

        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        view.addSubview(tableView)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc private func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleOutsideTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}

extension RolloverPopupModalViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BottomSheetOptionTableViewCell", for: indexPath) as! BottomSheetOptionTableViewCell
        let option = options[indexPath.row]
        let isSelected = option.0 == selectedOption
        cell.configure(with: option, isSelected: isSelected)
        cell.checkBoxTapped = { [weak self] in
            self?.selectedOption = option.0
            self?.selectionHandler?(self?.selectedOption ?? "")
            self?.dismiss(animated: true, completion: nil)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = options[indexPath.row]
        selectedOption = option.0
        selectionHandler?(selectedOption ?? "")
        dismiss(animated: true, completion: nil)
    }
}
