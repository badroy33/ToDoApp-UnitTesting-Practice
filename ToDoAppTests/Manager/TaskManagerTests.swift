//
//  TaskManagerTests.swift
//  ToDoAppTests
//
//  Created by Maksym Levytskyi on 05.06.2021.
//

import XCTest
@testable import ToDoApp

class TaskManagerTests: XCTestCase {
    
    var sut: TaskManager!

    override func setUpWithError() throws {
        sut = TaskManager()
    }

    override func tearDownWithError() throws {
        sut = nil
    }


    func testInitWithZeroTaskCount(){
        
        XCTAssertEqual(sut.tasksCount, 0)
    }
    
    func testInitTaskManagerWithZeroDoneTasks() {
        XCTAssertEqual(sut.doneTasksCount, 0)
    }
    
    func testInitTaskManagerWithZeroTasks() {
        XCTAssertEqual(sut.tasksCount, 0)
    }
    
    
    func testAddTaskIncrementTaskCount(){
        let task = Task(title: "Foo")
        sut.addTask(task: task)
        XCTAssertEqual(sut.tasksCount, 1)
    }
    
    
    func testTaskAtIndexIsAddedTask(){
        let task = Task(title: "Foo")
        sut.addTask(task: task)
        let returnetTask = sut.task(at: 0)
        
        XCTAssertEqual(task.title, returnetTask.title)
    }

    
    func testCheckTaskAtIndexChangesCount(){
        let task = Task(title: "Foo")
        sut.addTask(task: task)
        
        sut.checkTask(at: 0)
        
        XCTAssertTrue(sut.tasksCount == 0)
        XCTAssertTrue(sut.doneTasksCount == 1)
    }
    
    
    func testCheckTaskRemovedFromTasks(){
        let firstTask = Task(title: "Foo")
        let secondTask = Task(title: "Bar")
        
        sut.addTask(task: firstTask)
        sut.addTask(task: secondTask)
        sut.checkTask(at: 0)

        XCTAssertEqual(sut.task(at: 0), secondTask)
    }
    
    func testDoneTaskReturnsAtCheckedTask(){
        let task = Task(title: "Foo")
        
        sut.addTask(task: task)
        sut.checkTask(at: 0)
        
        let returnedTask = sut.doneTask(at: 0)
        
        XCTAssertEqual(task, returnedTask)
    }
    
    
    func testRemoveAllResultsCountBeZero(){
        let firstTask = Task(title: "Foo")
        let secondTask = Task(title: "Bar")
         
        sut.addTask(task: firstTask)
        sut.addTask(task: secondTask)
        sut.checkTask(at: 0)
        sut.removeAll()
        
        XCTAssertEqual(sut.tasksCount, 0)
        XCTAssertEqual(sut.doneTasksCount, 0)
    }
    
    func testAddingSameObjectDoesNotIncrementCount(){
        sut.addTask(task: Task(title: "Foo"))
        sut.addTask(task: Task(title: "Foo"))
        
        XCTAssertTrue(sut.tasksCount == 1 )
    }
}
