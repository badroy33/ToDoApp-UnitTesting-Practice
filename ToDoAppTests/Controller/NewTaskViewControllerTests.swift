//
//  NewTaskViewControllerTests.swift
//  ToDoAppTests
//
//  Created by Maksym Levytskyi on 08.06.2021.
//

import XCTest
import CoreLocation

@testable import ToDoApp

class NewTaskViewControllerTests: XCTestCase {
    
    var sut: NewTaskViewController!
    var placemark: MockCLPlaceMark!

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: String(describing: NewTaskViewController.self)) as? NewTaskViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHasTitleTextField(){
        XCTAssertTrue(sut.titleTextField.isDescendant(of: sut.view))
    }
    
    func testHasLocationTextField(){
        XCTAssertTrue(sut.locationTextField.isDescendant(of: sut.view))
    }
    
    func testHasDateTextField(){
        XCTAssertTrue(sut.dateTextField.isDescendant(of: sut.view))
    }
    
    func testHasAdressTextField(){
        XCTAssertTrue(sut.adressTextField.isDescendant(of: sut.view))
    }
    
    func testHasDescriptionTextField(){
        XCTAssertTrue(sut.descriptionTextField.isDescendant(of: sut.view))
    }
    
    func testHasSaveButton(){
        XCTAssertTrue(sut.saveButton.isDescendant(of: sut.view))
    }
    
    func testHasCancelButton(){
        XCTAssertTrue(sut.cnacelButton.isDescendant(of: sut.view))
    }
    
    func testSaveUsesGeocoderToConvertCoordinateFromAdress(){
        sut.titleTextField.text = "Foo"
        sut.locationTextField.text = "Bar"
        sut.dateTextField.text = "08.06.21"
        sut.adressTextField.text = "Львов"
        sut.descriptionTextField.text = "Baz"
        sut.taskManager = TaskManager()
        let mockGeocoder = MockCLGeocoder()
        sut.geocoder = mockGeocoder
        sut.save()
        
        let df = DateFormatter()
        df.dateFormat = "dd.MM.YY"
        let date = df.date(from: "08.06.21")
        
        
        
        let coordinate = CLLocationCoordinate2D(latitude:  49.8416993, longitude: 24.0309003)
        let location = Location(name: "Bar", coordinate: coordinate)
        let generatetTask = Task(title: "Foo", description: "Baz", date: date, location: location)
        
        placemark = MockCLPlaceMark()
        placemark.mockCoordinate = coordinate
        mockGeocoder.completionHandler?([placemark], nil)
        
        let task = sut.taskManager.task(at: 0)
        
        XCTAssertEqual(task, generatetTask)
    }
    
    func testSaveButtonHasSaveMethod(){
        let saveButton = sut.saveButton
        
        guard let actions = saveButton?.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail()
            return
        }
        
        XCTAssertTrue(actions.contains("save"))
    }
    
    func testGeocoderFetchesCorrectCoordinate(){
        
        let geocodeAnswer = expectation(description: "Geocode expectation")
        let adressString = "Львов"
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(adressString) { placemarks, error in
            let placemark = placemarks?.first
            let location = placemark?.location
            guard let latitude = location?.coordinate.latitude,
                  let longetude = location?.coordinate.longitude else {
                XCTFail()
                return
            }
            
            XCTAssertEqual(latitude, 49.8416993)
            XCTAssertEqual(longetude, 24.0309003)
            geocodeAnswer.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testSaveDissmisesNewTaskViewController(){
        let mockNewTaskViewController = MockNewTaskViewController()
        mockNewTaskViewController.titleTextField = UITextField()
        mockNewTaskViewController.titleTextField.text = "Foo"
        mockNewTaskViewController.locationTextField = UITextField()
        mockNewTaskViewController.locationTextField.text = "Bar"
        mockNewTaskViewController.dateTextField = UITextField()
        mockNewTaskViewController.dateTextField.text = "08.06.21"
        mockNewTaskViewController.adressTextField = UITextField()
        mockNewTaskViewController.adressTextField.text = "Lviv"
        mockNewTaskViewController.descriptionTextField = UITextField()
        mockNewTaskViewController.descriptionTextField.text = "Baz"
        
        //when
        mockNewTaskViewController.save()
        
        //then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            XCTAssertTrue(mockNewTaskViewController.isDismissed)
        }
    }


}

extension NewTaskViewControllerTests{
    class MockCLGeocoder: CLGeocoder{
        
        var completionHandler: CLGeocodeCompletionHandler?
        
        override func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
            self.completionHandler = completionHandler
        }
    }
    
    class MockCLPlaceMark: CLPlacemark{
        
        var mockCoordinate: CLLocationCoordinate2D!
        
        override var location: CLLocation?{
            return CLLocation(latitude: mockCoordinate.latitude, longitude: mockCoordinate.longitude)
        }
    }
}

extension NewTaskViewControllerTests{
    class MockNewTaskViewController: NewTaskViewController{
        var isDismissed = false
        
        
        override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
            isDismissed = true
        }
            
    }
}
