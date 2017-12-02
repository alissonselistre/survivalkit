//
//  BeaconTableViewCell.swift
//  SurvivalKit
//
//  Created by Alisson L. Selistre on 02/12/17.
//  Copyright © 2017 Alisson. All rights reserved.
//

import UIKit
import CoreLocation

class BeaconTableViewCell: UITableViewCell {

    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var minorLabel: UILabel!

    static let identifier = "BeaconTableViewCell"
    static let height: CGFloat = 60

    func setup(withBeacon beacon: Beacon) {
        majorLabel.text = beacon.major
        minorLabel.text = beacon.minor
    }
}
