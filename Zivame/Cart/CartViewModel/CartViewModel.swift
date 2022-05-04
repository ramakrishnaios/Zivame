//
//  CartViewModel.swift
//  ZivameTask
//
//  Created by ram krishna on 01/05/22.
//

import Foundation
class CartViewModel : NSObject {
    
    var cartItems : [CartItems]? {
        didSet {
            self.bindCartItemsData()
            let totalPrices = self.cartItems?.compactMap({Int($0.productPrice ?? "")})
            self.totalCartValue = totalPrices?.reduce(0, { x,y in
                x + y
            }) ?? 0
        }
    }
    
    var bindCartItemsData : (() -> ()) = {}
    var bindTotalCartValue : (() -> ()) = {}
    override init() {
        super.init()
        fetchCartItems()
    }
    func fetchCartItems(){
        if let itemsInCart = CartItems.fetchAllCartItems(context: ItemCoreDataStorage.sharedInstances.context) {
            cartItems = itemsInCart
        }
    }
    
    var totalCartValue : Int? {
        didSet {
            self.bindTotalCartValue()
        }
    }
    
   
    func removeCartItems(){
        CartItems.emptyCar(context: ItemCoreDataStorage.sharedInstances.context, storeCoOrdinater: ItemCoreDataStorage.sharedInstances.storeCoordinator)
        fetchCartItems()
    }
}
