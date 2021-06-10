//
//  TaskTests.swift
//  ToDoAppTests
//
//  Created by Maksym Levytskyi on 04.06.2021.
//

import XCTest
@testable import ToDoApp

class TaskTests: XCTestCase {
  
    func testTaskInitTaskWithTitle(){
        let task = Task(title: "Foo")
        
        XCTAssertNotNil(task)
    }
    
    func testTaskInitTaskWithTitleAndDescription(){
        let task = Task(title: "Foo", description: "Bar")
        
        XCTAssertNotNil(task)
    }
    
    
    func testWhenGivenTitleSetsTitle(){
        let task = Task(title: "Foo")
        
        XCTAssertEqual(task.title, "Foo")
    }
    
    func testWhenGivenDescriptionSetsTitle(){
        let task = Task(title: "Foo", description: "Bar")
        
        XCTAssertEqual(task.description, "Bar")
    }
    
    func testTaskInitsWithDate(){
        let task = Task(title: "Foo")
        
        XCTAssertNotNil(task.date)
    }
    
    func testWhenGivenLocationSetsLocation(){
        
        let location = Location(name: "Foo")
        
        let task = Task(title: "Bar",
                        description: "Baz",
                        location: location)
        
        XCTAssertEqual(location, task.location)
    }
}
