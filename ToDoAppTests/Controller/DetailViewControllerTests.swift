//
//  DetailViewControllerTests.swift
//  ToDoAppTests
//
//  Created by Maksym Levytskyi on 08.06.2021.
//

import XCTest
import CoreLocation
@testable import ToDoApp


class DetailViewControllerTests: XCTestCase {
    var sut: DetailViewController!

    override func setUpWithError() throws {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyBoard.instantiateViewController(identifier: String(describing: DetailViewController.self)) as? DetailViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHasTitleLabel(){
        XCTAssertNotNil(sut.titleLabel)
        XCTAssertTrue(sut.titleLabel.isDescendant(of: sut.view))
    }
    
    func testHasDesctiptionLabel(){
        
        XCTAssertNotNil(sut.descriptionLabel)
        XCTAssertTrue(sut.descriptionLabel.isDescendant(of: sut.view))
    }
    
    func testHasDateLabel(){
        
        XCTAssertNotNil(sut.dateLabel)
        XCTAssertTrue(sut.dateLabel.isDescendant(of: sut.view))
    }
    
    func testHasMapLabel(){
        
        XCTAssertNotNil(sut.mapView)
        XCTAssertTrue(sut.mapView.isDescendant(of: sut.view))
    }
    
    func testHasLocationLabel(){
        
        XCTAssertNotNil(sut.locationLabel)
        XCTAssertTrue(sut.locationLabel.isDescendant(of: sut.view))
    }
    
    func setUpTaskAndApppearanceTransition(){
        let coordinate = CLLocationCoordinate2D(latitude: 49.841952, longitude: 24.0315921)
        let location = Location(name: "Baz", coordinate: coordinate)
        let task = Task(title: "Foo", description: "Bar", date: Date(timeIntervalSince1970: 1623161855), location: location)
        
        sut.task = task
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
    }
    
    func testSettingTaskSetsTitleLabel(){
        setUpTaskAndApppearanceTransition()
        
        XCTAssertEqual(sut.titleLabel.text, "Foo")
    }
    
    func testSettingTaskSetsDescriptionLabel(){
        setUpTaskAndApppearanceTransition()
        
        XCTAssertEqual(sut.descriptionLabel.text, "Bar")
    }
    
    func testSettingTaskSetsLocationLabel(){
        setUpTaskAndApppearanceTransition()
        
        XCTAssertEqual(sut.locationLabel.text, "Baz")
    }
    
    func testSettingTaskSetsDateLabel(){
        setUpTaskAndApppearanceTransition()
        
        XCTAssertEqual(sut.dateLabel.text, "08.06.21")
    }

    func testSettingTaskSetsMapView(){
        setUpTaskAndApppearanceTransition()
        
        XCTAssertEqual(sut.mapView.centerCoordinate.latitude, 49.841952, accuracy: 0.001)
        
        XCTAssertEqual(sut.mapView.centerCoordinate.longitude, 24.0315921, accuracy: 0.001)
    }
}
