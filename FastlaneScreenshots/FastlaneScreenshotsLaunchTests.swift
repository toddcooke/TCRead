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
            
    override func setUp() {
        super.setUp()
        
        let app = XCUIApplication()
        app.launchEnvironment["SKIP_EMAIL"] = "alice@kindle.com"
        setupSnapshot(app)
        app.launch()
    }

    func testLaunch() throws {
        snapshot("0Launch")
        let app = XCUIApplication()
        // TODO: figure out why XCUIDevice is not in scope
        //XCUIDevice.sharedDevice.orientation = .Portrait
        
        let bookSearchNavigationBar = app.navigationBars["Book Search"]
        let searchSearchField = bookSearchNavigationBar.searchFields["Search"]
        searchSearchField.tap()
        searchSearchField.typeText("a")
        searchSearchField.typeText("l")
        searchSearchField.typeText("i")
        searchSearchField.typeText("c")
        searchSearchField.typeText("e")
        searchSearchField.typeText("\n") //  dismiss keyboard
        
        let ladingElement = app.collectionViews.element(boundBy: 0).cells.matching(identifier: "ProgressView").element

        // wait until timeout reached
        waitNotExistance(for: ladingElement)
        
        XCUIApplication().cells
          .containing(.staticText, identifier: "Alice's Adventures in Wonderland")
          .firstMatch
          .tap()
        snapshot("1BookDetail")
    }
    
    func waitNotExistance(for element: XCUIElement, timeout: Double = 5) {
        let notExists = NSPredicate(format: "exists != 1")
        let elementShown = expectation(for: notExists, evaluatedWith: element)
        wait(for: [elementShown], timeout: timeout, enforceOrder: false)
    }

}


