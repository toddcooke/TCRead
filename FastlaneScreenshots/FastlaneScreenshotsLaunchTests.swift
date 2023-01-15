//
//  FastlaneScreenshotsLaunchTests.swift
//  FastlaneScreenshots
//
//  Created by Todd Cooke on 1/13/23.
//

import XCTest

final class FastlaneScreenshotsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        
        let app = XCUIApplication()
        let bookSearchNavigationBar = app.navigationBars["Book Search"]
        let searchSearchField = bookSearchNavigationBar.searchFields["Search"]
        searchSearchField.tap()
        app.collectionViews/*@START_MENU_TOKEN@*/.buttons["Alice's Adventures in Wonderland,  Lewis Carroll"]/*[[".cells.buttons[\"Alice's Adventures in Wonderland,  Lewis Carroll\"]",".buttons[\"Alice's Adventures in Wonderland,  Lewis Carroll\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["Book Search"].tap()
        searchSearchField.tap()
        setupSnapshot(app)
        snapshot("01LoginScreen")
        searchSearchField.buttons["Clear text"].tap()
        bookSearchNavigationBar.buttons["Cancel"].tap()
        
        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
