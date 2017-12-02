//
//  Item.swift
//  SurvivalKit
//
//  Created by Alisson L. Selistre on 02/12/17.
//  Copyright © 2017 Alisson. All rights reserved.
//

import UIKit

struct Item {
    var name = ""
    var image: UIImage?
    var beacon: Beacon?
}

extension Item: Equatable {
    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name && lhs.beacon == rhs.beacon
    }
}
