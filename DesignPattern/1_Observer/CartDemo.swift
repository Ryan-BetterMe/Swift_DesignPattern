//
//  CartDemo.swift
//  DesignPattern
//
//  Created by 向辉 on 2023/12/12.
//

import Foundation
import AppKit

protocol CartSubscriber: CustomStringConvertible {
    func accept(changed cart: [any Product])
}

protocol Product: Equatable {
    var id: Int { get }
    var name: String { get }
    var price: Decimal { get }
}

extension Product {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Food: Product {
    var id: Int
    var name: String
    var price: Decimal
    
    var calories: Int
}

struct Clothes: Product {
    var id: Int
    var name: String
    var price: Decimal
    
    var size: String
}

// Publisher
class CartManager {
    private var cart = [any Product]()
    private var subscribers = [any CartSubscriber]()
    
    func add(subscriber: CartSubscriber) {
        subscribers.append(subscriber)
    }
    
    func remove(subscriber filter: (CartSubscriber) -> Bool) {
        guard let index = subscribers.firstIndex(where: filter) else { return }
        
        subscribers.remove(at: index)
    }
    
    func notifySubscribers() {
        subscribers.forEach {
            $0.accept(changed: cart)
        }
    }
    
    func add(product: any Product) {
        cart.append(product)
        
        notifySubscribers()
    }
    
    func remove(product: any Product) {
        guard let index = cart.firstIndex(where: { $0.id == product.id }) else { return }
        
        cart.remove(at: index)
        
        notifySubscribers()
    }
}

extension NSToolbar: CartSubscriber {
    open override var description: String { return "NSToolbar" }
    
    func accept(changed cart: [any Product]) {
        print("NSToolbar: Updating an appearance of navigation item \(cart.count)")
    }
}

extension NSViewController: CartSubscriber {
    open override var description: String { return "NSViewController" }
    
    func accept(changed cart: [any Product]) {
        print("CartViewController: Updating an appearance of a list view with products \(cart.count)")
    }
}
