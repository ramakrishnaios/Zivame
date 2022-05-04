//
//  ProductsListDataSource.swift
//  ZivameTask
//
//  Created by ram krishna on 01/05/22.
//

import Foundation
import UIKit
import CoreData
class ProductListTableViewDataSource<CELL : UITableViewCell, T, T1, T2, viewController:UIViewController> : NSObject, UITableViewDataSource, UITableViewDelegate {

    private var cellIdentifier : String!
    private var items : [T]?
    var configureCell : (CELL, T1?, T2?, IndexPath) -> () = {_,_,_,_  in }
    private var priceLessThan1000 : [T1]?
    private var priceGreaterThan1000 : [T2]?
    weak var viewcontroller : UIViewController?
    init(cellIdentifier : String, items : [T]?, priceLessThan1000:[T1]?,priceGreaterThan1000:[T2]?, viewcontroller:UIViewController, configureCell : @escaping (CELL, T1?, T2?,IndexPath) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.priceLessThan1000 = priceLessThan1000
        self.priceGreaterThan1000 = priceGreaterThan1000
        self.configureCell = configureCell
        self.viewcontroller = viewcontroller
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
           return self.priceLessThan1000?.count ?? 0
        }
        else {
            return self.priceGreaterThan1000?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CELL
        if indexPath.section == 0 {
        self.configureCell(cell, priceLessThan1000?[indexPath.row],nil, indexPath)
        }
        else {
            self.configureCell(cell, nil,priceGreaterThan1000?[indexPath.row], indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return  "> 1000"
        }
        else{
          return  "< 1000"
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var actions: [(String, UIAlertAction.Style)] = []
            actions.append(("YES", .default))
        actions.append(("NO", .cancel))
        Alerts.showActionsheet(viewController: self.viewcontroller ?? UIViewController(), title: "Do you want add this product to cart?", message: "", actions: actions) { index in
            switch index {
            case 0:
                //add product to cart DB
                if indexPath.section == 0 {
                   if let productObject = self.priceLessThan1000?[indexPath.row] as? Products {
                       CartItems.insertItemIntoCart(item: productObject, context: ItemCoreDataStorage.sharedInstances.context)
                    }
                }
                else {
                    if let productObject = self.priceGreaterThan1000?[indexPath.row] as? Products {
                        CartItems.insertItemIntoCart(item: productObject, context: ItemCoreDataStorage.sharedInstances.context)
                     }
                 }
            default:
                break
            }
        }
    }
}





