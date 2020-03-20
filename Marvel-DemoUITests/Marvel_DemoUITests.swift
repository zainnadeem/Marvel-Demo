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
        let marvelDemoNavigationBar = app.navigationBars["Marvel-Demo"]
        let searchByIdButton = marvelDemoNavigationBar.buttons["Search By Id"]
        searchByIdButton.tap()
        
        let okayButton = app.alerts["Search Comics"].scrollViews.otherElements.buttons["Okay"]
        okayButton.tap()
        searchByIdButton.tap()
        okayButton.tap()
        marvelDemoNavigationBar.buttons["VoiceOver"].tap()
        app.alerts["Enable VoiceOver"].scrollViews.otherElements.buttons["Okay"].tap()

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
