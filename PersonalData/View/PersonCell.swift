//
//  DataCell.swift
//  PersonalData
//
//  Created by Daria Ten on 15.11.2021.
//

import UIKit

final class PersonCell: UITableViewCell {
	
	static let reuseIdentifier = "PersonCell"
	
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

	// MARK: -  Initialization

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		setupConstraints()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Private

	private func setupConstraints() {
		contentView.addSubview(nameTextField)
		contentView.addSubview(ageTextField)
		
		NSLayoutConstraint.activate([
			nameTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
			nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			nameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
			nameTextField.bottomAnchor.constraint(equalTo: ageTextField.topAnchor, constant: -5),
			nameTextField.heightAnchor.constraint(equalToConstant: 40),
			ageTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			ageTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
			ageTextField.heightAnchor.constraint(equalToConstant: 40)
		])
	}

	// MARK: - Public

	func resetPersonText() {
		nameTextField.text?.removeAll()
		ageTextField.text?.removeAll()
	}
}
