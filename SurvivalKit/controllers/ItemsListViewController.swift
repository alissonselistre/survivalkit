//
//  ItemsListViewController.swift
//  SurvivalKit
//
//  Created by Alisson L. Selistre on 02/12/17.
//  Copyright © 2017 Alisson. All rights reserved.
//

import UIKit
import CoreLocation

enum MasonState {
    case emptyList
    case everythingIsFine
    case lostItem
}

class ItemsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var masonContainer: UIView!
    @IBOutlet weak var masonImageView: UIImageView!
    @IBOutlet weak var masonMessageLabel: UILabel!

    var items: [Item] = []

	var newItem: Item?

    var masonState = MasonState.emptyList

    var hasLostItem = false
	
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupRefreshRoutine()
        setupObservers()
        refreshUI()
    }

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(true)
		let filemanager = LocalFileManager()
		if let itemsArray = filemanager.loadObjects(key: "item") as? [Item]{
			self.items = itemsArray
		}
	}
	
    // MARK: setup

    private func setupUI() {
        masonMessageLabel.layer.masksToBounds = true
        masonMessageLabel.layer.cornerRadius = masonMessageLabel.frame.width / 4
        masonMessageLabel.layer.borderWidth = 1
        masonMessageLabel.layer.borderColor = UIColor.lightGray.cgColor
    }

    private func setupRefreshRoutine() {
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (timer) in
            self.refreshUI()
        }
    }

    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(checkForMissingItems), name: Notification.Name(BeaconDetector.foundTheDoorNotificationIdentifier), object: nil)
    }

    // MARK: update
    private func refreshUI() {
		tableView.reloadData()

        updateMasonState()

        UIView.transition(with: masonContainer, duration: 1, options: .transitionCrossDissolve, animations: {
            switch self.masonState {
            case .emptyList:
                self.masonImageView.image = #imageLiteral(resourceName: "monster1")
                self.masonMessageLabel.text = "Bora cadastrar\n uns bagulho\n pra nois cuidá"
            case .everythingIsFine:
                self.masonImageView.image = #imageLiteral(resourceName: "monster1")
                self.masonMessageLabel.text = "Por hora,\ntudo nos\nconforme"
            case .lostItem:
                self.masonImageView.image = #imageLiteral(resourceName: "monster2")
                self.masonMessageLabel.text = "O meo! Tu tá esquecendo\num bagulho!"
            }
        }, completion: nil)
    }

    // MARK: helpers

    @objc internal func checkForMissingItems() {
        NotificationHelper.generateNotification()
    }

    func updateMasonState() {
		if items.count == 0 {
            masonState = .emptyList
        } else if BeaconDetector.shared.hasLostItem {
			
			
			masonState = .lostItem
        } else {
            masonState = .everythingIsFine
        }
    }

    // MARK: actions

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
