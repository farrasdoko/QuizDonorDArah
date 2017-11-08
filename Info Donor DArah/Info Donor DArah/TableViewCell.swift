//
//  TableViewCell.swift
//  Info Donor DArah
//
//  Created by Gw on 08/11/17.
//  Copyright © 2017 Gw. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var labelHeight: UILabel!
    @IBOutlet weak var labelCountry: UILabel!
    @IBOutlet weak var labelName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
