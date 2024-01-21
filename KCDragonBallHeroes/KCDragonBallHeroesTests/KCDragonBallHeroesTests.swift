//
//  KCDragonBallHeroesTests.swift
//  KCDragonBallHeroesTests
//
//  Created by Robert Aguero on 1/20/24.
//

import XCTest
@testable import KCDragonBallHeroes

final class KCDragonBallHeroesTests: XCTestCase {
    private var token:String?
    
    override func setUp(){
        super.setUp()
        print("SetUp by every test")
    }
    
    override class func setUp() {
        super.setUp()
        print("SetUp by all class")
    }
    
    override func tearDown() {
        super.tearDown()
        print("tearDown by every test")
    }
    
    override class func tearDown() {
        super.tearDown()
        print("tearDown by all class")
    }

    func test_tokenIsJWT(){
        token = "eyJraWQiOiJwcml2YXRlIiwidHlwIjoiSldUIiwiYWxnIjoiSFMyNTYifQ.eyJpZGVudGlmeSI6IkFEMTA0Qzk5LUQzN0ItNDdGMi1BNEEyLTEwQ0JBQzI4RUUyMyIsImV4cGlyYXRpb24iOjY0MDkyMjExMjAwLCJlbWFpbCI6InJvYmVydGFndWVyb0BnbWFpbC5jb20ifQ.EDz5WZ3fHnTAT9_mDdkf1Gdy1K7q0pWqJG6T-rs6ji4"
        
        XCTAssertTrue(token?.components(separatedBy: ".").count == 3, "Token bien formado")
    }

}
