//
//  TaskCellTest.swift
//  ToDoAppTests
//
//  Created by Maksym Levytskyi on 07.06.2021.
//

import XCTest
import CoreLocation
@testable import ToDoApp

class TaskCellTest: XCTestCase {

    var storyBoard: UIStoryboard!
    var controller: TaskListViewController!
    var tableView: UITableView!
    var cell: TaskCell!
    
    override func setUpWithError() throws {
        storyBoard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyBoard.instantiateViewController(identifier: String(describing: TaskListViewController.self)) as? TaskListViewController
        controller.loadViewIfNeeded()
        
        tableView = controller.tableView
        
        let dataSource = FakeDataSource()
        tableView.dataSource = dataSource
        
        cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TaskCell.self), for: IndexPath(row: 0, section: 0)) as? TaskCell
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testCellhasTitleLabel(){
        XCTAssertNotNil(cell.titleLabel)
    }
    
    func testCellhasTitleLabelInsideContentView(){
        XCTAssertTrue(cell.titleLabel.isDescendant(of: cell.contentView))
    }
    
    func testCellhasLocationLabel(){
        XCTAssertNotNil(cell.locationLabel)
    }
    
    func testCellhasLocationLabelInsideContentView(){
        XCTAssertTrue(cell.locationLabel.isDescendant(of: cell.contentView))
    }
    
    func testCellhasDateLabel(){
        XCTAssertNotNil(cell.dateLabel)
    }
    
    func testCellhasDateLabelInsideContentView(){
        XCTAssertTrue(cell.dateLabel.isDescendant(of: cell.contentView))
    }
    
    func testConfigureSetsTitle(){
        let task = Task(title: "Foo")
        
        cell.configure(withTask: task)
        
        XCTAssertEqual(task.title, cell.titleLabel.text)
    }
    
    func testConfigureSetsDate(){
        let task = Task(title: "Foo")
        
        cell.configure(withTask: task)
        
        let df = DateFormatter()
        
        df.dateFormat = "dd.MM.yy"
        let date = task.date
        let stringDate = df.string(from: date)
        
        XCTAssertEqual(stringDate, cell.dateLabel.text)
    }

    func testConfigureSetsLocation(){
        let location = Location(name: "Foo", coordinate: CLLocationCoordinate2D(latitude: 1, longitude: 1) )
        let task = Task(title: "Foo",
                        location: location)
        
        cell.configure(withTask: task)
        
        XCTAssertEqual(task.location?.name, cell.locationLabel.text)
    }
    
    func cinfigureCellWithTask(){
        let task = Task(title: "Foo")
        cell.configure(withTask: task, done: true)
    }
    
    func testDoneTaskShoudStrikeThrough(){
        cinfigureCellWithTask()
        
        let attributedString = NSAttributedString(string: "Foo", attributes: [NSAttributedString.Key.strikethroughStyle : NSUnderlineStyle.single.rawValue])
        
        XCTAssertEqual(attributedString, cell.titleLabel.attributedText )
    }
    
    func testWhenDoneIsTrueDoneTaskDateLabelEqualsNil(){
        cinfigureCellWithTask()
        
        XCTAssertNil(cell.dateLabel)
    }
    
    func testWhenDoneIsTrueDoneTaskLocationLabelEqualsNil(){
        cinfigureCellWithTask()
        
        XCTAssertNil(cell.locationLabel)
    }
}


extension TaskCellTest{
    class FakeDataSource: NSObject, UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}
