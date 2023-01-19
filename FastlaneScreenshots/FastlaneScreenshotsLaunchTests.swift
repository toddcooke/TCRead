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
        if UIDevice.current.userInterfaceIdiom == .phone {
            XCUIDevice.shared.orientation = .portrait
        }
        snapshot("0Launch")
        let app = XCUIApplication()

        let bookSearchNavigationBar = app.navigationBars["Book Search"]
        let searchSearchField = bookSearchNavigationBar.searchFields["Search"]
        searchSearchField.tap()
        searchSearchField.typeText("a")
        searchSearchField.typeText("l")
        searchSearchField.typeText("i")
        searchSearchField.typeText("c")
        searchSearchField.typeText("e")
        searchSearchField.typeText("\n") //  dismiss keyboard

        sleep(3) // wait for book cover to load
        XCUIApplication().cells
            .containing(.staticText, identifier: "Alice's Adventures in Wonderland")
            .firstMatch
            .tap()
        snapshot("1BookDetail")
    }
}
