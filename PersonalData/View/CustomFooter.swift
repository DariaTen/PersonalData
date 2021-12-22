//
//  CustomFooter.swift
//  PersonalData
//
//  Created by Daria Ten on 17.11.2021.
//

import UIKit

final class CustomFooter: UITableViewHeaderFooterView {
	
	static let reuseIdentifier = "FooterCell"

	weak var output: ViewControllerProtocol?
	weak var delegate: UIViewController?

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	lazy var resetAllButton: UIButton = {
		let removeAllButton = UIButton(type: .system)
		removeAllButton.translatesAutoresizingMaskIntoConstraints = false
		removeAllButton.setTitle("Очистить", for: .normal)
		removeAllButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
		removeAllButton.layer.borderWidth = 2
		removeAllButton.setTitleColor(UIColor(named: "redColor"), for: .normal)
		removeAllButton.layer.borderColor = UIColor(named: "redColor")?.cgColor
		removeAllButton.layer.cornerRadius = 20
		
		return removeAllButton
	}()

	// MARK: - Initialization

	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)

		setUpConstraints()
	}

	// MARK: - Private

	private func setUpConstraints() {
		contentView.addSubview(resetAllButton)
		
		resetAllButton.addTarget(self, action: #selector(didTapRemoveButton), for: .touchUpInside)
		
		NSLayoutConstraint.activate([
			resetAllButton.centerXAnchor.constraint(equalTo: centerXAnchor),
			resetAllButton.widthAnchor.constraint(equalToConstant: 180),
			resetAllButton.heightAnchor.constraint(equalToConstant: 40),
			resetAllButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
		])
	}

	// MARK: - Actions

	@objc private func didTapRemoveButton() {
		showActionSheet()
	}

	private func showActionSheet() {
		let actionSheet = UIAlertController(title: "Сбросить данные?", message: "", preferredStyle: .actionSheet)

		actionSheet.addAction(UIAlertAction(title: "Сбросить данные", style: .destructive, handler: { action in
			self.output?.resetCell()
			
		}))
		actionSheet.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
		delegate?.present(actionSheet, animated: true, completion: nil)
	}
}
