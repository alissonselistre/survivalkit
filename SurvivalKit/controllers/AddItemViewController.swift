//
//  AddItemViewController.swift
//  ChallengeFour_Autolayout
//
//  Created by Cristiano Salla Lunardi on 12/2/17.
//  Copyright © 2017 Cristiano Salla Lunardi. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
	
	@IBOutlet weak var itemName: UITextField!
	@IBOutlet weak var itemImage: UIImageView!
	@IBOutlet weak var viewTest: UIView!
	@IBOutlet weak var pickerView: UIPickerView!
	
	var beacons : [String] = ["35790", "36034"]
	var selectedBeacon : String?
	let picker = UIImagePickerController()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		selectedBeacon = beacons.first
		let tap = UITapGestureRecognizer(target: self, action: #selector(self.tap(_:)))
		tap.delegate = self
		itemImage.isUserInteractionEnabled = true
		itemImage.addGestureRecognizer(tap)
		viewTest.addGestureRecognizer(tap)
		picker.delegate = self
		pickerView.delegate = self
	}
	
	@IBAction func addItem(_ sender: Any) {
		if let name = itemName.text{
			if let photo = itemImage.image{
				if let beacon = selectedBeacon{
					let fileManager = LocalFileManager()
					var items = [Item]()
					if let userDefaultsArray = fileManager.loadObjects(key: "item") as? [Item] {
						items = userDefaultsArray
					}
					items.append(Item.init(name: name, image: photo, beacon: (selectedBeacon)!))
					fileManager.persistObjects(objects: items, key: "item")
				}
			}
		}
	}
	
	@objc func tap(_ gestureRecognizer: UITapGestureRecognizer) {
		
		let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
		
		// 2
		let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {
			(alert: UIAlertAction!) -> Void in
			let imagePicker = UIImagePickerController()
			imagePicker.delegate = self
			imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
			imagePicker.allowsEditing = false
			self.present(imagePicker, animated: true, completion: nil)
		})
		let galleryAction = UIAlertAction(title: "Gallery", style: .default, handler: {
			(alert: UIAlertAction!) -> Void in
			self.picker.allowsEditing = false
			self.picker.sourceType = .photoLibrary
			self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
			self.present(self.picker, animated: true, completion: nil)
		})
		
		//
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
			(alert: UIAlertAction!) -> Void in
			print("Cancelled")
		})
		
		
		// 4
		optionMenu.addAction(cameraAction)
		optionMenu.addAction(galleryAction)
		optionMenu.addAction(cancelAction)
		
		// 5
		self.present(optionMenu, animated: true, completion: nil)
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		
		if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
			itemImage.image = image
		}
		
		dismiss(animated: true){
			
		}
		
	}
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		dismiss(animated: true){
			
		}
	}
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	*/
	
}

extension AddItemViewController: UIPickerViewDelegate, UIPickerViewDataSource{
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return beacons.count
	}
	
	func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
		let labelText = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 30))
		labelText.text = beacons[row]
		return labelText
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		selectedBeacon = beacons[row]
	}
	
}
