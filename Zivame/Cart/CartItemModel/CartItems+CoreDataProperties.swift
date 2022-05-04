//
//  CartItems+CoreDataProperties.swift
//  Zivame
//
//  Created by ram krishna on 02/05/22.
//
//

import Foundation
import CoreData


extension CartItems {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CartItems> {
        return NSFetchRequest<CartItems>(entityName: "CartItems")
    }

    @NSManaged public var productName: String?
    @NSManaged public var productRating: Int32
    @NSManaged public var productPrice: String?
    @NSManaged public var productImagePath: String?

}

extension CartItems : Identifiable {
    class func insertItemIntoCart(item:Products?,context:NSManagedObjectContext) {
        let product = CartItems(context: context)
        product.productName = item?.name
        product.productImagePath = item?.image_url
        product.productPrice = item?.price
        product.productRating = Int32(item?.rating ?? 0)
        do {
            try context.save()
        } catch let e{
            print(e.localizedDescription)
        }
        
    }
    
    class func fetchAllCartItems(context:NSManagedObjectContext) -> [CartItems]? {
        var fetchReq = NSFetchRequest<NSFetchRequestResult>()
        fetchReq = CartItems.fetchRequest()
        do {
        let results = try context.fetch(fetchReq)
            if let cartItems = results as? [CartItems]{
                return cartItems
            }
            else {
                return nil
            }
        }
        catch {
           return nil
        }
    }
    
    class func emptyCar(context:NSManagedObjectContext,storeCoOrdinater:NSPersistentStoreCoordinator){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CartItems")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try storeCoOrdinater.execute(deleteRequest, with: context)
        } catch let e {
            // TODO: handle the error
            print(e.localizedDescription)
        }
    }
}
