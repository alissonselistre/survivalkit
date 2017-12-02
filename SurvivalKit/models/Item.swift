//
//  Item.swift
//  SurvivalKit
//
//  Created by Alisson L. Selistre on 02/12/17.
//  Copyright © 2017 Alisson. All rights reserved.
//

import UIKit

class Item: NSObject, NSCoding{
	func encode(with aCoder: NSCoder) {
		aCoder.encode(name, forKey: "name")
		aCoder.encode(image, forKey: "image")
		aCoder.encode(beaconID, forKey: "beaconID")
	}
	
	required init?(coder aDecoder: NSCoder) {
		self.name = aDecoder.decodeObject(forKey: "name") as! String
		if let image =  aDecoder.decodeObject(forKey: "image") as? UIImage{
			self.image = image
		}else{
			return nil
		}
		if let beaconID = aDecoder.decodeObject(forKey: "beaconID") as? String{
			self.beaconID = beaconID
		}else{
			return nil
		}
	}
	
	init(name: String, image: UIImage?, beacon: String?) {
		self.name = name
		self.image = image
		self.beaconID = beacon
	}
	
    var name = ""
    var image: UIImage?
    var beaconID: String?
}
