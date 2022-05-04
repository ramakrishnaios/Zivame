//
//  APICallManager.swift
//  ZivameTask
//
//  Created by ram krishna on 01/05/22.
//

import Foundation
public enum Result<Success, Failure: Error> {
  /// A success, storing a `Success` value.
  case success(Success)

  /// A failure, storing a `Failure` value.
  case failure(Failure)
}

class APIService :  NSObject {
    let baseURL : String = "https://my-json-server.typicode.com"
    let productsListEndPoint : String = "/nancymadan/assignment/db"
    
    func fetchProductListData(apiEndPoint:String,completion : @escaping  (Result<ProductList?, Error>) -> Void){
        guard let url = URL.init(string: baseURL + apiEndPoint) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            do {
                let result = try JSONDecoder().decode(ProductList.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
