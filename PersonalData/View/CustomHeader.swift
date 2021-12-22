//
//  CustomHeaderFooter.swift
//  PersonalData
//
//  Created by Daria Ten on 17.11.2021.
//

import UIKit

final class CustomHeader: UITableViewHeaderFooterView {
	
	static let reuseIdentifier = "HeaderCell"

	weak var output: ViewControllerProtocol?

	lazy var headerLabel: UILabel = {
		let headerLabel = UILabel()
		headerLabel.translatesAutoresizingMaskIntoConstraints = false
		headerLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
		headerLabel.textColor = .black
		
		return headerLabel
	}()
	
	lazy var addButton : UIButton = {
		let addButton = UIButton(type: .system)
		addButton.translatesAutoresizingMaskIntoConstraints = false
		addButton.setTitle(" + Добавить ребенка ", for: .normal)
		addButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
		addButton.setTitleColor(UIColor(named: "lightBlue"), for: .normal)
		addButton.layer.borderWidth = 2
		addButton.layer.borderColor = UIColor(named: "lightBlue")?.cgColor
		addButton.layer.cornerRadius = 20
		
		return addButton
	}()

	// MARK: - Initialization

	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)

		setUpConstraints()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: -  Private

	private func setUpConstraints() {

		contentView.addSubview(addButton)
		contentView.addSubview(headerLabel)
		
		addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
		
		NSLayoutConstraint.activate([
			headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			headerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
			addButton.topAnchor.constraint(equalTo: contentView.topAnchor),
			addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
			addButton.widthAnchor.constraint(equalToConstant: 180),
			addButton.heightAnchor.constraint(equalToConstant: 40),
		])
	}

	// MARK: - Public

	func configure(with title: String?, for section: Int) {
		headerLabel.text = title
		addButton.isHidden = section == 0
	}

	func hideAddButton(for section: Int) {
		addButton.isHidden = section == 1
	}

	// MARK: - Actions

	@objc private func didTapAddButton() {
		output?.addCell()
	}
}
