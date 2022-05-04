//
//  CartItemsDataSource.swift
//  Zivame
//
//  Created by ram krishna on 02/05/22.
//

import Foundation
import UIKit
import CoreData
class CartItemsDataSource<CELL : UITableViewCell, T, TABLEBG:UIView> : NSObject, UITableViewDataSource, UITableViewDelegate {
    private var cellIdentifier : String!
    private var items : [T]?
    var configureCell : (CELL, T?) -> () = {_,_  in }
    var viewBG : UIView?
    init(cellIdentifier : String, items : [T]?, tableBGView:UIView, configureCell : @escaping (CELL, T?) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.viewBG = tableBGView
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.items?.count ?? 0 > 0 {
            tableView.backgroundView = nil
            return self.items?.count ?? 0
        }
        else {
            tableView.backgroundView = self.viewBG
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CELL
        let item = self.items?[indexPath.row]
        self.configureCell(cell,item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
