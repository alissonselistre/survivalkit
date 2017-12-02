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
        Item(name: "Guarda-Chuva", image: nil, beacon: nil),
        Item(name: "Carteira", image: nil, beacon: nil),
        Item(name: "Óculos", image: nil, beacon: nil)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

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
        }
        return UITableViewCell()
    }
}

extension ItemsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ItemTableViewCell.height
    }
}
