//
//  LocalFileManager.swift
//  SurvivalKit
//
//  Created by Cristiano Salla Lunardi on 12/2/17.
//  Copyright © 2017 Alisson. All rights reserved.
//

import UIKit

struct LocalFileManager {
	private let userDefaults = UserDefaults.standard
	
	private let key = "Object"
	
	private func objectsToNSData(objects: [Any]) -> [Data]{
		var objectsDataArray = [Data]()
		for object in objects{
			objectsDataArray.append(NSKeyedArchiver.archivedData(withRootObject: object))
		}
		return objectsDataArray
	}
	
	func persistObjects(objects : [Any]){
		let objectsData = objectsToNSData(objects: objects)
		self.userDefaults.setValue(objectsData, forKey: key)
		self.userDefaults.synchronize()
	}
	
	func loadObjects() -> [Any]?{
		if let object = userDefaults.value(forKey: key){
			let objectsData = object as! [Data]
			var objectsArray = [Any]()
			for objectData in objectsData{
				objectsArray.append(NSKeyedUnarchiver.unarchiveObject(with: objectData) as Any)
			}
			return objectsArray
		}
		return nil
	}
	
}

