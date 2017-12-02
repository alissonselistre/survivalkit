//
//  Beacon.swift
//  SurvivalKit
//
//  Created by Alisson L. Selistre on 02/12/17.
//  Copyright © 2017 Alisson. All rights reserved.
//

import UIKit
import CoreLocation

struct Beacon {
    var major = ""
    var minor = ""

    init(clBeacon: CLBeacon) {
        major = "\(clBeacon.major)"
        minor = "\(clBeacon.minor)"
    }
}

extension Beacon: Equatable {
    static func ==(lhs: Beacon, rhs: Beacon) -> Bool {
        return lhs.major == rhs.major && lhs.minor == rhs.minor
    }
}
