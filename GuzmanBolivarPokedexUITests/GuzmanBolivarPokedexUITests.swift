//
//  GuzmanBolivarPokedexUITests.swift
//  GuzmanBolivarPokedexUITests
//
//  Created by Alejandro Guzman Bolivar on 6/18/23.
//

import XCTest

final class GuzmanBolivarPokedexUITests: XCTestCase {

  let app = XCUIApplication()

  override func setUpWithError() throws {
    continueAfterFailure = false
    app.launch()
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func test_ContentView_TabBar_TabBarExistAndWorks() {
    // Given
    let tabBar = app.tabBars["Tab Bar"]
    let introTabButton = tabBar.buttons["Intro"]
    let listTabButton = tabBar.buttons["List"]
    let profileTabButton = tabBar.buttons["Profile"]

    // Then
    XCTAssertTrue(introTabButton.isSelected)
    XCTAssertFalse(listTabButton.isSelected)
    XCTAssertFalse(profileTabButton.isSelected)

    listTabButton.tap()

    XCTAssertTrue(listTabButton.isSelected)
    XCTAssertFalse(introTabButton.isSelected)
    XCTAssertFalse(profileTabButton.isSelected)

    profileTabButton.tap()
    XCTAssertFalse(listTabButton.isSelected)
    XCTAssertFalse(introTabButton.isSelected)
    XCTAssertTrue(profileTabButton.isSelected)
  }
}
