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
    var lastDetection = Date()

    init(clBeacon: CLBeacon) {
        major = "\(clBeacon.major)"
        minor = "\(clBeacon.minor)"
    }

    var isInRange: Bool {
        let now = Date()
        return abs(lastDetection.timeIntervalSince(now)) <= 5
    }
}

extension Beacon: Equatable {
    static func ==(lhs: Beacon, rhs: Beacon) -> Bool {
        return lhs.major == rhs.major && lhs.minor == rhs.minor
    }
}
