//
//  CoreDataManager.swift
//  Zivame
//
//  Created by ram krishna on 02/05/22.
//

import Foundation
import CoreData
import UIKit
public class ItemCoreDataStorage {
    static let sharedInstances : ItemCoreDataStorage = ItemCoreDataStorage()
    var context: NSManagedObjectContext
    var storeCoordinator  : NSPersistentStoreCoordinator
    private init(){
        let application = UIApplication.shared.delegate as! AppDelegate
        self.context = application.persistentContainer.viewContext
        self.storeCoordinator = application.persistentContainer.persistentStoreCoordinator
    }
}
