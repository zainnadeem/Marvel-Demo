//
//  Marvel_DemoTests.swift
//  Marvel-DemoTests
//
//  Created by Zain Nadeem on 3/17/20.
//  Copyright © 2020 Zain Nadeem. All rights reserved.
//

import XCTest
import SwiftyJSON
import Alamofire
import Marvel_Demo

@testable import Marvel_Demo

class Marvel_DemoTests: XCTestCase {
    var testId = 61756
    func testRequestComicWithIdCall() {
        let expect = expectation(description: "Download should succeed")
        MarvelAPICall.shared.requestComicById(id: testId) { (response, error) in
            if let err = error {
                XCTFail("API response error: \(err.localizedDescription)")
            }
            XCTAssertNil(error, "Unexpected error occured: \(String(describing: error?.localizedDescription))")
            if let res = response {
                XCTAssertEqual(res.coverImageURL, "http://i.annihil.us/u/prod/marvel/i/mg/f/b0/588bbfe8ecc21", file: "Image URL was incorrect")
                XCTAssertEqual(res.title, "The Unstoppable Wasp (2017) #2", file: "Title was incorrect")
                XCTAssertEqual(res.description, "Nadia is on a mission to bring together the brightest Girl Geniuses of the Marvel Universe and change the world, but first, she has to figure out how to find them and get them to join her. With her chaperone Jarvis by her side, her first recruiting mission is going to take her to Washington Heights in search of one of the greatest young engineering minds of our time...one no one has even heard of. Guest-starring Lunella Lafayette, The Miraculous Moon Girl!", file: "Description was incorrect")
            }
            expect.fulfill()
        }
        waitForExpectations(timeout: 10) { (error) in
            XCTAssertNil(error, "Test timed out. \(String(describing: error?.localizedDescription))")
        }
        
    }

}
