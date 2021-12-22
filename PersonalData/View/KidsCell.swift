//
//  KidsCell.swift
//  PersonalData
//
//  Created by Daria Ten on 15.11.2021.
//

import UIKit

final class KidsCell: UITableViewCell {

	static let reuseIdentifier = "KidsCell"
	weak var output: ViewControllerProtocol?
	
	let nameTextField: UITextField = {
		let nameTextField = UITextField()
		nameTextField.translatesAutoresizingMaskIntoConstraints = false
		nameTextField.placeholder = "Имя"
		nameTextField.borderStyle = .roundedRect
		
		return nameTextField
	}()
	let ageTextField: UITextField = {
		let ageTextField = UITextField()
		ageTextField.translatesAutoresizingMaskIntoConstraints = false
		ageTextField.placeholder = "Возраст"
		ageTextField.borderStyle = .roundedRect
		
		return ageTextField
	}()
	let deleteButton : UIButton = {
		let deleteButton = UIButton(type: .system)
		deleteButton.translatesAutoresizingMaskIntoConstraints = false
		deleteButton.setTitle("Удалить", for: .normal)
		deleteButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
		deleteButton.setTitleColor(UIColor(named: "lightBlue"), for: .normal)
		
		return deleteButton
	}()

	// MARK: - Initialization
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		setUpConstraints()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Private

	private func setUpConstraints() {
		contentView.addSubview(nameTextField)
		contentView.addSubview(ageTextField)
		contentView.addSubview(deleteButton)
		
		deleteButton.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)
		
		NSLayoutConstraint.activate([
			nameTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
			nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			nameTextField.bottomAnchor.constraint(equalTo: ageTextField.topAnchor, constant: -10),
			nameTextField.heightAnchor.constraint(equalToConstant: 40),
			nameTextField.widthAnchor.constraint(equalToConstant: 150),
			deleteButton.leadingAnchor.constraint(equalTo: nameTextField.trailingAnchor, constant: 20),
			deleteButton.topAnchor.constraint(equalTo: nameTextField.topAnchor, constant: 10),
			ageTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			ageTextField.heightAnchor.constraint(equalToConstant: 40),
			ageTextField.widthAnchor.constraint(equalToConstant: 150),
		])
	}

	// MARK: - Actions

	@objc private func didTapDeleteButton() {
		output?.deleteCell()
	}

	// MARK: - Public

	func resetKidsText() {
		nameTextField.text?.removeAll()
		ageTextField.text?.removeAll()
	}
}
