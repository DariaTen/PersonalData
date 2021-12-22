//
//  ViewController.swift
//  PersonalData
//
//  Created by Daria Ten on 15.11.2021.
//

import UIKit

protocol ViewControllerProtocol: AnyObject {

	func addCell()

	func deleteCell()

	func resetCell()
}

final class ViewController: UIViewController {
	
	private lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.rowHeight = 120
		tableView.separatorStyle = .none
		tableView.sectionFooterHeight = 50
		tableView.sectionHeaderHeight = 50
		tableView.register(PersonCell.self, forCellReuseIdentifier: PersonCell.reuseIdentifier)
		tableView.register(KidsCell.self, forCellReuseIdentifier: KidsCell.reuseIdentifier)
		tableView.register(CustomHeader.self, forHeaderFooterViewReuseIdentifier: CustomHeader.reuseIdentifier)
		tableView.register(CustomFooter.self, forHeaderFooterViewReuseIdentifier: CustomFooter.reuseIdentifier)
		tableView.dataSource = self
		tableView.delegate = self
		
		return tableView
	}()
	private let sectionHeaders = ["Персональные данные", "Дети (макс. 5)"]
	private let rowsInPersonSection = 1
	private var rowsInKidsSection = 0

	override func viewDidLoad() {
		super.viewDidLoad()
		
		setUpConstraints()
		view.backgroundColor = .white
	}
	
	// MARK: - Set Up View
	
	private func setUpConstraints(){
		view.addSubview(tableView)
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
			tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		sectionHeaders.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		section == 0 ? rowsInPersonSection : rowsInKidsSection
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let reuseId = indexPath.section == 0
		? PersonCell.reuseIdentifier
		: KidsCell.reuseIdentifier

		let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)

		if let kidCell = cell as? KidsCell {
			kidCell.output = self
			if rowsInKidsSection == 0 {
				kidCell.resetKidsText()
			}
		} else if let personCell = cell as? PersonCell {
			if rowsInKidsSection == 0 {
				personCell.resetPersonText()
			}
		}
		return cell
	}
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomHeader.reuseIdentifier) as? CustomHeader

		header?.output = self
		header?.configure(with: sectionHeaders[section], for: section)

		if rowsInKidsSection == 5 {
			header?.hideAddButton(for: 1)
		}

		return header
	}

	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		guard sectionHeaders.count - 1 == section
		else { return nil }

		let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomFooter.reuseIdentifier) as? CustomFooter
		view?.output = self
		view?.delegate = self

		return view
	}
}

// MARK: - ViewControllerProtocol

extension ViewController: ViewControllerProtocol {
	
	func addCell() {
		if rowsInKidsSection < 5 {
			rowsInKidsSection += 1
			tableView.reloadData()
		}
	}
	
	func deleteCell() {
		rowsInKidsSection -= 1
		tableView.deleteRows(at: [IndexPath(row: rowsInKidsSection, section: 1)], with: .automatic)
		tableView.reloadData()
	}

	func resetCell() {
		tableView.reloadData()
		rowsInKidsSection = 0
	}
}
