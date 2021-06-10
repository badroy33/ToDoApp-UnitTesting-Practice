//
//  ToDoAppTests.swift
//  ToDoAppTests
//
//  Created by Maksym Levytskyi on 04.06.2021.
//

import XCTest
@testable import ToDoApp

class ToDoAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitialViewControllerIsTaskListViewController(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        let rootViewController = navigationController.viewControllers.first as! TaskListViewController
        XCTAssertTrue(rootViewController is TaskListViewController)
    }

}
