//
//  RestaurantDetailViewController.swift
//  CustomSideMenuiOSExample
//
//  Created by Audrey Shingleton on 10/20/21.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: RestaurantDetailHeaderView!
    
    var restaurant = Restaurant(name: "", imageString: "", type: "", price: "", description: "")

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.tintColor = .white
        // Configure header view
        headerView.headerImageView.image = UIImage(named: restaurant.imageString)
        headerView.nameLabel.text = restaurant.name
        // change color of heart icon for favorited restaurants
        let isFavorite = restaurant.isFavorite ?? false
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
