//
//  DetailOrderCell.swift
//  CustomSideMenuiOSExample
//
//  Created by Audrey Shingleton on 11/17/21.
//

import UIKit

class DetailOrderCell: UITableViewCell {
    
    @IBOutlet var quantityLabel: UILabel!
    @IBOutlet var quantityStepper: UIStepper!
    @IBOutlet var orderButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
