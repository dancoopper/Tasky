//
//  group69UITestsLaunchTests.swift
//  group69UITests
//
//  Primary author: Samuel Browne (101481884)
//
//  Other editors:
//  - Sokmontrey Sythat (101477705): Screenshot attachment for launch screen review.
//  - Jonathan Cao (101480537): `runsForEachTargetApplicationUIConfiguration` setup.
//

import XCTest

final class group69UITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
