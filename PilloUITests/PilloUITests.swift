//
//  PilloUITests.swift
//  PilloUITests
//
//  Created by Manuel Cubillo on 1/27/19.
//  Copyright © 2019 Manuel Cubillo. All rights reserved.
//

import XCTest
@testable import Pillo

class PilloUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDontSegueToCallingIfPendingFriend() {
        let careFriendsTable = app.tables["careFriendsTable"]
        let friendCell = careFriendsTable.cells.containing(.image, identifier:"celina").firstMatch
        friendCell.tap()
        
        XCTAssert(careFriendsTable.exists, "Expected to find Care Friends table but didn't")
    }
    
    func testSegueToCallingIfFriend() {
        //tap approved friend
        let careFriendsTable = app.tables["careFriendsTable"]
        let friendCell = careFriendsTable.cells.containing(.image, identifier:"alicia").firstMatch
        friendCell.tap()
        
        XCTAssertFalse(careFriendsTable.exists, "Expected to not find Care Friends table but did")
        
        //confirm on Calling VC
        let careFriendName = app.staticTexts["friendName"]
        XCTAssert(careFriendName.exists, "Expected to find friend name label but didn't")
    }
    
    func testHangupCallFromCallingIfTapHangupButton() {
        let careFriendsTable = app.tables["careFriendsTable"]
        let friendCell = careFriendsTable.cells.containing(.image, identifier:"alicia").firstMatch
        friendCell.tap()
        
        let hangupButton = app.buttons["callingHangupButton"]
        XCTAssert(hangupButton.exists,"Expected to find hang up button but didn't")
        hangupButton.tap()
        
        XCTAssert(careFriendsTable.exists, "Expected to find Care Friends table but didn't")
    }
    
    func testSegueToAnswerIfCalling() {
        let careFriendsTable = app.tables["careFriendsTable"]
        let friendCell = careFriendsTable.cells.containing(.image, identifier:"alicia").firstMatch
        friendCell.tap()
        
        //Label on AnswerVC
        let callingFriendLabel = app.staticTexts["callingFriendLabel"]
        XCTAssertFalse(callingFriendLabel.exists, "Expected to not find Calling Friend label but did")
        
        //wait for segue to AnswerVC
        let predicate = NSPredicate(format:"exists == 1")
        let exp = expectation(for: predicate, evaluatedWith: callingFriendLabel, handler: nil)
        let result = XCTWaiter.wait(for: [exp], timeout: 7.0)
        
        if result == XCTWaiter.Result.completed {
            XCTAssert(callingFriendLabel.exists,"Expected to find Calling Friend label but didn't")
        } else {
            XCTAssert(false,"Issue occured seguing to AnswerVC")
        }
    }
    
    func testHangupCallFromAnswerIfTapHangupButton() {
        let careFriendsTable = app.tables["careFriendsTable"]
        let friendCell = careFriendsTable.cells.containing(.image, identifier:"alicia").firstMatch
        friendCell.tap()
        
        let hangupButton = app.buttons["answeringHangupButton"]
        XCTAssertFalse(hangupButton.exists, "Expected to not find Answering hang up button but did")
        
        //wait for segue to AnswerVC
        let predicate = NSPredicate(format:"exists == 1")
        let exp = expectation(for: predicate, evaluatedWith: hangupButton, handler: nil)
        let result = XCTWaiter.wait(for: [exp], timeout: 7.0)
        
        if result == XCTWaiter.Result.completed {
            XCTAssert(hangupButton.exists,"Expected to find Anwering hang up button but didn't")
        } else {
            XCTAssert(false,"Issue occured seguing to AnswerVC")
        }
        
        hangupButton.tap()
        XCTAssert(careFriendsTable.exists,"Expected to find Care Friends table but didn't")
    }
    
    func testCallingLabelIsFriendNameIfSegueToCalling() {
        let careFriendsTable = app.tables["careFriendsTable"]
        let friendCell = careFriendsTable.cells.containing(.image, identifier:"alicia").firstMatch
        friendCell.tap()
        
        let careFriendName = app.staticTexts["friendName"]
        XCTAssertEqual(careFriendName.label , "Alicia Cory")
    }
    
    func testCallingLabelIsFriendNameIfSegueToAnswering() {
        let careFriendsTable = app.tables["careFriendsTable"]
        let friendCell = careFriendsTable.cells.containing(.image, identifier:"alicia").firstMatch
        friendCell.tap()
        
        let callingFriendLabel = app.staticTexts["callingFriendLabel"]
        XCTAssertFalse(callingFriendLabel.exists, "Expected to not find Calling Friend Label but did")
        
        //wait for segue to AnswerVC
        let predicate = NSPredicate(format:"exists == 1")
        let exp = expectation(for: predicate, evaluatedWith: callingFriendLabel, handler: nil)
        let result = XCTWaiter.wait(for: [exp], timeout: 7.0)
        
        if result == XCTWaiter.Result.completed {
            XCTAssertEqual(callingFriendLabel.label,"Alicia Cory")
        } else {
            XCTAssert(false,"Issue occured seguing to AnswerVC")
        }
    }
}
