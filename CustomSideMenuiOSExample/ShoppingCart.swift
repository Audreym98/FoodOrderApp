//
//  ShoppingCart.swift
//  CustomSideMenuiOSExample
//
//  Created by Audrey Shingleton on 12/1/21.
//

import Foundation

class ShoppingCart {
    // shared ensures global access
    static let shared = ShoppingCart()
    
    // item to quantity
    var cart: [Restaurant: Int]?
    
    private init() {
        // empty cart upon init
        self.cart = [:]
    }
    
    func addToCart(item: Restaurant, quantity: String) {
        print(item.name)
        print(item.price)
        print(quantity)
    }
    
    func removeFromCart() {}
}
