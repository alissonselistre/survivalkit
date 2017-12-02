//
//  ItemTableViewCell.swift
//  SurvivalKit
//
//  Created by Alisson L. Selistre on 02/12/17.
//  Copyright © 2017 Alisson. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    static let identifier = "ItemTableViewCell"
    static let height: CGFloat = 100

    var isInRange = false {
        didSet {
            if isInRange {
                backgroundColor = UIColor.green.withAlphaComponent(0.2)
            } else {
                backgroundColor = UIColor.white
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    // MARK: setup

    func setup(withItem item: Item) {
        photoImageView.image = item.image
        nameLabel.text = item.name
    }

    private func setupUI() {
        photoImageView.layer.masksToBounds = true
        photoImageView.layer.cornerRadius = photoImageView.frame.size.width / 2
        isInRange = false
    }
}
