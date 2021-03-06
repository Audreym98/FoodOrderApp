//
//  MenuDetailViewController.swift
//  CustomSideMenuiOSExample
//
//  Created by Audrey Shingleton on 10/20/21.
//

import UIKit

class MenuDetailViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: MenuDetailHeaderView!
    
    var menuItem: MenuItem = MenuItem(name: "", imageString: "", type: "", price: "", description: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none

        navigationController?.navigationBar.tintColor = .white
        // Configure header view
        headerView.headerImageView.image = UIImage(named: menuItem.imageString)
        headerView.nameLabel.text = menuItem.name
        headerView.priceLabel.text = menuItem.price
        // change color of heart icon for favorited menu item
        let isFavorite = menuItem.isFavorite ?? false
        let heartImage = isFavorite ? "heart.fill" : "heart"
        headerView.heartButton.tintColor = isFavorite ? .systemYellow : .white
        headerView.heartButton.setImage(UIImage(systemName: heartImage), for: .normal)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MenuDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 2 rows of data
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String (describing: DetailTextCell.self), for: indexPath) as! DetailTextCell
            cell.descriptionLabel.text = menuItem.description
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String (describing: DetailOrderCell.self), for: indexPath) as! DetailOrderCell
            cell.quantityLabel.text = "1"
            cell.quantityStepper.value = 1
            cell.item = menuItem
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        default:
            fatalError("Failed to instantiate the table view cell for detail view controller")
        }
    }
}

extension UIViewController : DetailTableViewCellDelegate {
    func detailTableViewCell(_ detailTableViewCell: DetailOrderCell, orderTappedFor itemName: String, orderQuantityFor quantity: String) {
    let alert = UIAlertController(title: "Added to cart!", message: " item: \(itemName), quantity: \(quantity)", preferredStyle: .alert)
    // okay button to close alert
    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(okAction)
    self.present(alert, animated: true, completion: nil)
  }
}
