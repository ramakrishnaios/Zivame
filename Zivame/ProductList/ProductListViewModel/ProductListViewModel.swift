//
//  File.swift
//  ZivameTask
//
//  Created by ram krishna on 01/05/22.
//

import Foundation
import UIKit
class ProductListViewModel : NSObject {
    
    private var apiService : APIService!
    var productsLessThan1000 : [Products]?
    var productsMoreThan1000 : [Products]?
    var prodcutListData : ProductList? {
        didSet {
            let products = prodcutListData?.products
            productsLessThan1000 = products?.filter({Int($0.price ?? "0") ?? 0 < 1000})
            productsMoreThan1000 = products?.filter({Int($0.price ?? "0") ?? 0 > 1000})
            self.bindProductsData()
        }
    }
    
    var bindProductsData : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService =  APIService()
        getProductsData()
    }
    
    func getProductsData() {
        self.apiService.fetchProductListData(apiEndPoint: self.apiService.productsListEndPoint) { apiResponse in
            switch apiResponse {
            case .success(let productList):
                self.prodcutListData = productList
            case .failure(let failedError):
                print(failedError.localizedDescription)
            }
        }
    }
    
}
