//
//  SortByCell.swift
//  Yelp
//
//  Created by Danny Glover on 4/9/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class SortByCell: UITableViewCell {

    @IBOutlet weak var sortByLabel: UILabel!
    @IBOutlet weak var isSelectedImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        isSelectedImageView.image = UIImage(named: "notselected")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
