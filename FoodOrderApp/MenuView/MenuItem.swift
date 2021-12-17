//
//  Restaurant.swift
//  CustomSideMenuiOSExample
//
//  Created by Audrey Shingleton on 10/13/21.
//

import Foundation

struct MenuItem: Hashable, Decodable {
    
    var name: String
    var imageString: String
    var type: String
    var price: String
    var description: String
    var isFavorite: Bool?
    
    init(name: String, imageString: String, type: String, price: String, description: String) {
        self.name = name
        self.imageString = imageString
        self.type = type
        self.price = price
        self.description = description
        self.isFavorite = false
    }
}

class MenuItemsModel {
    
    weak var delegate: Downloadable?
    let networkModel = Network()
    
    func downloadRestaurants(url: String) {
           let request = networkModel.request(url: url)
           networkModel.response(request: request) { (data) in
               let model = try! JSONDecoder().decode([MenuItem]?.self, from: data) as [MenuItem]?
               self.delegate?.didReceiveData(data: model! as [MenuItem])
           }
       }
}
