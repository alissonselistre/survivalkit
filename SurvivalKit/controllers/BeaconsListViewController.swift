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

    internal var beacons: [Beacon] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    private let locationManager = CLLocationManager()
    private var beaconRegion = CLBeaconRegion(proximityUUID: UUID(uuidString: BEACON_UUID)!, identifier: BEACON_REGION_IDENTIFIER)

    // MARK: view methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
    }

    // MARK: setup

    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()

        beaconRegion.notifyEntryStateOnDisplay = true
        beaconRegion.notifyOnEntry = true
        beaconRegion.notifyOnExit = true

        if (!CLLocationManager.isRangingAvailable()) {
            // TODO: message to location unavailable
            return
        }

        startMonitoringBeacons()
    }

    // MARK: helpers

    private func startMonitoringBeacons() {
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(in: beaconRegion)
    }

    private func stopMonitoringBeacons() {
        locationManager.stopMonitoring(for: beaconRegion)
        locationManager.stopRangingBeacons(in: beaconRegion)
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

extension BeaconsListViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint("Failed monitoring region: \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        debugPrint("Location manager failed: \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        debugPrint("Beacons found: \(beacons.count)")

        for clBeacon in beacons {

            let beacon = Beacon(clBeacon: clBeacon)
            if let index = self.beacons.index(of: beacon) {
                self.beacons[index] = beacon
            } else {
                self.beacons.append(beacon)
            }
        }
    }
}
