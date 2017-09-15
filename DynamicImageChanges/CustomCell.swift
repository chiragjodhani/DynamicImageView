//
//  CustomCell.swift
//  DynamicImageChanges
//
//  Created by Eryus Developer on 15/09/17.
//  Copyright © 2017 Eryushion Techsol. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var lblText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
