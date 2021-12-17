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
    var cart: [MenuItem: Int]
    var subtotal: Float
    
    private init() {
        // empty cart upon init
        self.cart = [:]
        self.subtotal = 0
    }
    
    func addToCart(item: MenuItem, quantity: String) {
        let quantity = Int(quantity) ?? 1
        let price = Float(item.price.dropFirst()) ?? 0
        // check if key exists
        if self.cart[item] != nil {
            self.cart[item]! += quantity
        } else {
            self.cart[item] = quantity
        }
        self.subtotal += Float(quantity) * price
        print(item.name)
        print(self.cart[item] ?? "none")
        print(self.subtotal)
    }
    
    func removeOneFromCart(item: MenuItem) {
        self.cart[item]! -= 1
        let price = Float(item.price.dropFirst()) ?? 0
        self.subtotal -= price
        
        print(self.cart[item] ?? "none")
        print(self.subtotal)
    }
    
    func getQuantity(item: MenuItem) -> Int {
        return cart[item] ?? 0
    }
    
    func getSubtotalFormatted() -> String {
        return "$" + String(format: "%.2f", self.subtotal)
    }
    
    func clearCart() {
        self.cart = [:]
        self.subtotal = 0
    }
}
