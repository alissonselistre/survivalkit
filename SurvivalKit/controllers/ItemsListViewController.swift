//
//  ItemsListViewController.swift
//  SurvivalKit
//
//  Created by Alisson L. Selistre on 02/12/17.
//  Copyright © 2017 Alisson. All rights reserved.
//

import UIKit
import CoreLocation

class ItemsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var items: [Item] = [
//        Item(name: "Guarda-Chuva", image: nil, beacon: "35790"),
//        Item(name: "Carteira", image: nil, beacon: "36034"),
//        Item(name: "Óculos", image: nil, beacon: "8317")
    ]

	var newItem: Item?
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshRoutine()
        setupObservers()
    }

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(true)
		let filemanager = LocalFileManager()
		if let itemsArray = filemanager.loadObjects(key: "item") as? [Item]{
			self.items = itemsArray
		}
	}
	
    // MARK: setup

    private func setupRefreshRoutine() {
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (timer) in
            self.refreshUI()
        }
    }

    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(checkForMissingItems), name: Notification.Name(BeaconDetector.foundTheDoorNotificationIdentifier), object: nil)
    }

    // MARK: updates

    private func refreshUI() {
		tableView.reloadData()
    }

    // MARK: helpers

    @objc internal func checkForMissingItems() {
        NotificationHelper.generateNotification()
    }
	
	@IBAction func unwindToItemList(segue:UIStoryboardSegue) {

	}
}

extension ItemsListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifier, for: indexPath) as? ItemTableViewCell {
            let item = items[indexPath.row]
            cell.setup(withItem: item)
            cell.isInRange = BeaconDetector.shared.validBeacons.filter { $0.minor == item.beaconID }.first != nil
            return cell
        }
        return UITableViewCell()
    }
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			tableView.beginUpdates()
			items.remove(at: indexPath.row)
			let fileManager = LocalFileManager()
			fileManager.persistObjects(objects: items, key: "item")
			tableView.deleteRows(at: [indexPath], with: .automatic)
			tableView.endUpdates()
			tableView.reloadData()
		}
	}
	
}

extension ItemsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ItemTableViewCell.height
    }
}
