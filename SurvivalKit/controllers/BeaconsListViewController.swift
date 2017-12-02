//
//  BeaconsListViewController.swift
//  SurvivalKit
//
//  Created by Alisson L. Selistre on 02/12/17.
//  Copyright © 2017 Alisson. All rights reserved.
//

import UIKit
import CoreLocation

class BeaconsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    internal var beacons: [Beacon] {
        return BeaconDetector.shared.validBeacons
    }

    // MARK: view methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshRoutine()
    }

    // MARK: setup

    private func setupRefreshRoutine() {
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (timer) in
            self.refreshUI()
        }
    }

    // MARK: updates

    private func refreshUI() {
        tableView.reloadData()
    }
}

extension BeaconsListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beacons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: BeaconTableViewCell.identifier, for: indexPath) as? BeaconTableViewCell {
            let beacon = beacons[indexPath.row]
            cell.setup(withBeacon: beacon)
        }
        return UITableViewCell()
    }
}

extension BeaconsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return BeaconTableViewCell.height
    }
}
