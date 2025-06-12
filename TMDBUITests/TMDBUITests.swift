//
//  TMDBUITests.swift
//  TMDBUITests
//
//  Created by Jorge Ramos on 17/05/25.
//

// MARK: - UI Tests Adaptados

import XCTest

final class TMDBUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    func testSwitchingTabs() {
        let app = XCUIApplication()
        app.launch()

        let watchlistTab = app.buttons["Watchlist"]
        let profileTab = app.buttons["Profile"]
        let discoverTab = app.buttons["Discover"]

        XCTAssertTrue(watchlistTab.exists)
        XCTAssertTrue(profileTab.exists)
        XCTAssertTrue(discoverTab.exists)

        watchlistTab.tap()
        XCTAssertTrue(app.staticTexts["Watchlist"].exists)

        profileTab.tap()
        XCTAssertTrue(app.staticTexts["Profile"].exists)

        discoverTab.tap()
        XCTAssertTrue(app.staticTexts["MovieGPT"].exists)
    }
}

