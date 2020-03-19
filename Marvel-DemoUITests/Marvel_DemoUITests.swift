//
//  Marvel_DemoUITests.swift
//  Marvel-DemoUITests
//
//  Created by Zain Nadeem on 3/17/20.
//  Copyright © 2020 Zain Nadeem. All rights reserved.
//

import XCTest

class Marvel_DemoUITests: XCTestCase {

    func testExample() {
        let app = XCUIApplication()
        app.launch()
        let searchByIdButton = app.navigationBars["Marvel"].buttons["Search By Id"]
        searchByIdButton.tap()
        
        let elementsQuery = app.alerts["Search Comics"].scrollViews.otherElements
        let okButton = elementsQuery.buttons["OK"]
        okButton.tap()
        searchByIdButton.tap()
        elementsQuery.collectionViews.cells.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element.tap()
        okButton.tap()
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
