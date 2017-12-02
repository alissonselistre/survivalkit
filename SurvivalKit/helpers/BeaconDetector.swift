//
//  BeaconDetector.swift
//  SurvivalKit
//
//  Created by Alisson L. Selistre on 02/12/17.
//  Copyright © 2017 Alisson. All rights reserved.
//

import UIKit
import CoreLocation

class BeaconDetector: NSObject {

    static let shared = BeaconDetector()

    internal var allBeacons: [Beacon] = []

    var validBeacons: [Beacon] {
        return allBeacons.filter { $0.isInRange }
    }

    private let locationManager = CLLocationManager()
    private var beaconRegion = CLBeaconRegion(proximityUUID: UUID(uuidString: BEACON_UUID)!, identifier: BEACON_REGION_IDENTIFIER)

    // MARK: init

    override init() {
        super.init()
        self.setupLocationManager()
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
    }

    // MARK: helpers

    func startMonitoringBeacons() {
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(in: beaconRegion)
    }

    func stopMonitoringBeacons() {
        locationManager.stopMonitoring(for: beaconRegion)
        locationManager.stopRangingBeacons(in: beaconRegion)
    }
}

extension BeaconDetector: CLLocationManagerDelegate {

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
            if let index = self.allBeacons.index(of: beacon) {
                self.allBeacons[index] = beacon
            } else {
                self.allBeacons.append(beacon)
            }
        }
    }
}
