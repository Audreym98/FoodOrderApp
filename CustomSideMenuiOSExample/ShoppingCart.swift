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
    var cart: [Restaurant: Int]
    
    private init() {
        // empty cart upon init
        self.cart = [:]
    }
    
    func addToCart(item: Restaurant, quantity: String) {
        print(item.name)
        print(item.price)
        print(quantity)
        // check if key exists
        if self.cart[item] != nil {
            self.cart[item]! += Int(quantity)!
        } else {
            self.cart[item] = Int(quantity)
        }
        print(self.cart[item] ?? "none")
    }
    
    func removeFromCart() {}
    
    func getQuantity(item: Restaurant) -> Int {
        return cart[item] ?? 0
    }
}
