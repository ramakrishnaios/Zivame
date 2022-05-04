//
//  ZivameTestCases.swift
//  ZivameTestCases
//
//  Created by ram krishna on 03/05/22.
//

import XCTest
@testable import Zivame
class ZivameTestCases: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    // test api end point
    func testProductsAPIEndpoint() throws {
//    let mockEndPoint = "mymovieslist.com"
    let actualEndpoint = "/nancymadan/assignment/db"
      let apiCallManager = APIService()
        XCTAssertEqual(apiCallManager.productsListEndPoint, actualEndpoint)
    }
    //test api host addree
    func testProductsHostAddress() throws {
//    let mockHostAddress = "https://www.linkedin.com/"
    let actualHostAddress = "https://my-json-server.typicode.com"
      let apiCallManager = APIService()
        XCTAssertEqual(apiCallManager.baseURL, actualHostAddress)
    }
    
}
