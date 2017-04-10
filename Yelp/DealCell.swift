//
//  DealCell.swift
//  Yelp
//
//  Created by Danny Glover on 4/9/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol DealCellDelegate {
    @objc optional func dealCell(dealCell: DealCell, didChangeValue value: Bool)
    
}

class DealCell: UITableViewCell {

    @IBOutlet weak var onSwitch: UISwitch!
    
    var delegate: DealCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        onSwitch.addTarget(self, action: #selector(DealCell.switchValueChanged), for: UIControlEvents.valueChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func switchValueChanged () {
        print("switch value changed")
        delegate?.dealCell?(dealCell: self, didChangeValue: onSwitch.isOn)
    }

}
