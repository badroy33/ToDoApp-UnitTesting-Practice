//
//  DataProviderTests.swift
//  ToDoAppTests
//
//  Created by Maksym Levytskyi on 05.06.2021.
//

import XCTest
import UIKit
@testable import ToDoApp

class DataProviderTests: XCTestCase {
    var sut: DataProvider!
    var tableView: UITableView!
    
    var controller: TaskListViewController!
    
    

    override func setUpWithError() throws {
        sut = DataProvider()
        sut.taskManager = TaskManager()
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyBoard.instantiateViewController(identifier: String(describing: TaskListViewController.self)) as? TaskListViewController
        
        controller.loadViewIfNeeded()
        tableView = controller.tableView
        tableView.dataSource = sut
        tableView.delegate = sut
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNumberOfSectionsIsTwo(){
        let sut = DataProvider()
        let tableView = UITableView()
        tableView.dataSource = sut
        let numbersOfSections = tableView.numberOfSections
        XCTAssertTrue(numbersOfSections == 2)
    }
    
    
    func testNumberForRowsInSectionZeroIsTaskCount(){
        sut.taskManager?.addTask(task: Task(title: "Foo"))
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        
        sut.taskManager?.addTask(task: Task(title: "Bar"))
        
        tableView.reloadData()
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)

    }
    
    
    func testNumberForRowsInSectionOneIsDoneTaskCount(){
        sut.taskManager?.addTask(task: Task(title: "Foo"))
        sut.taskManager?.checkTask(at: 0)
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
        
        sut.taskManager?.addTask(task: Task(title: "Bar"))
        sut.taskManager?.checkTask(at: 0)
        
        tableView.reloadData()
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 2)
    }
    
    func testCellForRowAtIndexPathReturnsTaskCell(){
        sut.taskManager?.addTask(task: Task(title: "Foo"))
        
        tableView.reloadData()
        
        let taskCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(taskCell is TaskCell)
    }
    
    func testCellForRowAtIndexPathDequeuesCellFromTableView(){
        let mockTableView = MockTableView.mockTableView(withDataSource: sut)
        
        sut.taskManager?.addTask(task: Task(title: "Task"))
        
        mockTableView.reloadData()
        
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(mockTableView.cellIsDequeued)
    }
    
    func testCellForRowInSectionZeroCallsConfigure(){
        let mockTableView = MockTableView.mockTableView(withDataSource: sut)
        let task = Task(title: "Task")
        sut.taskManager?.addTask(task: task)
        
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockTaskCell
        
        XCTAssertEqual(task, cell.task)
    }
    
    func testCellForRowInSectionOneCallsConfigure(){
        let mockTableView = MockTableView.mockTableView(withDataSource: sut)
        let task = Task(title: "Task")
        sut.taskManager?.addTask(task: task)
        sut.taskManager?.checkTask(at: 0)
        
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! MockTaskCell
        
        XCTAssertEqual(task, cell.task)
    }
    
    func testDeleteButtonTitleSectionZeroShowsDone(){
        let buttonTitle = tableView.delegate?.tableView?(tableView, titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(buttonTitle, "Done")
    }
    
    func testDeleteButtonTitleSectionOneShowsDone(){
        let buttonTitle = tableView.delegate?.tableView?(tableView, titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0, section: 1))
        
        XCTAssertEqual(buttonTitle, "Undone")
    }
    
    func testCheckingTaskChecksInTaskManager(){
        let task = Task(title: "Foo")
        sut.taskManager?.addTask(task: task)
        
        tableView.dataSource?.tableView?(tableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(sut.taskManager?.tasksCount, 0)
        XCTAssertEqual(sut.taskManager?.doneTasksCount, 1)

    }
    
    func testUncheckingTaskUnchecksInTaskManager(){
        let task = Task(title: "Foo")
        sut.taskManager?.addTask(task: task)
        sut.taskManager?.checkTask(at: 0)
        tableView.reloadData()
        
        tableView.dataSource?.tableView?(tableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 1))
        
        XCTAssertEqual(sut.taskManager?.tasksCount, 1)
        XCTAssertEqual(sut.taskManager?.doneTasksCount, 0)
    }
}


extension DataProviderTests{
    class MockTableView: UITableView{
        var cellIsDequeued = false
        
        static func mockTableView(withDataSource dataSource: UITableViewDataSource) -> MockTableView{
            let mockTableView = MockTableView(frame: CGRect(x: 0, y: 0, width: 375, height: 658), style: .plain)
            mockTableView.dataSource = dataSource
            mockTableView.register(MockTaskCell.self, forCellReuseIdentifier: String(describing: TaskCell.self))
            return mockTableView
        }
        
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellIsDequeued = true
            
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
        
    }
    
    class MockTaskCell: TaskCell{
        var task: Task?
        
        override func configure(withTask task: Task, done: Bool = false){
            self.task = task
        }
    }
}
