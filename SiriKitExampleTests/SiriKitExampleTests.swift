//
//  SiriKitExampleTests.swift
//  SiriKitExampleTests
//
//  Created by Henrique Gouveia on 8/3/16.
//  Copyright © 2016 CI&T. All rights reserved.
//

import XCTest
@testable import SiriKitExample

class SiriKitExampleTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testItemFilterWithModelAndColor() {
        let itemDescription = "xadrez azul"
        let result = DataProvider.filterItem(itemDescription: itemDescription)

        assert(result.count == 1)
    }

    func testItemFilterWithCategory() {
        let itemDescription = "camisa"
        let result = DataProvider.filterItem(itemDescription: itemDescription)

        assert(result.count == 3)
    }
    
}
