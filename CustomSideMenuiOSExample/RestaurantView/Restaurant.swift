//
//  Restaurant.swift
//  CustomSideMenuiOSExample
//
//  Created by Audrey Shingleton on 10/13/21.
//

import Foundation

struct Restaurant: Hashable, Decodable {
    
    var name: String
    var type: String
    var location: String
    var imageString: String
    var isFavorite: Bool?
    
    init(name: String, imageString: String, location: String, type: String) {
        self.name = name
        self.imageString = imageString
        self.location = location
        self.type = type
        self.isFavorite = false
    }
}

class RestaurantsModel {
    
    weak var delegate: Downloadable?
    let networkModel = Network()
    
    func downloadRestaurants(url: String) {
           let request = networkModel.request(url: url)
           networkModel.response(request: request) { (data) in
               let model = try! JSONDecoder().decode([Restaurant]?.self, from: data) as [Restaurant]?
               self.delegate?.didReceiveData(data: model! as [Restaurant])
           }
       }
}
