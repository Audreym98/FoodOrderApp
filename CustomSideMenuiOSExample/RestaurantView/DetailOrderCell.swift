//
//  DetailOrderCell.swift
//  CustomSideMenuiOSExample
//
//  Created by Audrey Shingleton on 11/17/21.
//

import UIKit

class DetailOrderCell: UITableViewCell {
    
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var quantityStepper: UIStepper!
    @IBOutlet weak var orderButton: UIButton!
    var itemName: String = ""
    weak var delegate : DetailTableViewCellDelegate?
    
    @IBAction func quantityChanged(_ sender: UIStepper) {
        // assign value of stepper to quantity label
        quantityLabel.text = Int(sender.value).description
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.orderButton.addTarget(self, action: #selector(orderTapped(_:)), for: .touchUpInside)
        self.orderButton.setTitle("Add to cart", for: .normal)
        self.orderButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func orderTapped(_ sender: UIButton) {
        // access value of quanity and we need the item name
        // store this data somewhere
        // display itemName and quantityLabel.text in a pop-up
        if delegate != nil {
            self.delegate?.detailTableViewCell(self, orderTappedFor: self.itemName, orderQuantityFor: quantityLabel.text ?? "1")
        }
    }
}

protocol DetailTableViewCellDelegate: AnyObject {
    func detailTableViewCell(_  detailTableViewCell: DetailOrderCell, orderTappedFor itemName: String, orderQuantityFor quantity: String)
}
