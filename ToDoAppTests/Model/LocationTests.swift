//
//  LocationTests.swift
//  ToDoAppTests
//
//  Created by Maksym Levytskyi on 05.06.2021.
//

import XCTest
import CoreLocation
@testable import ToDoApp

class LocationTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitSetsName(){
        let location = Location(name: "Foo")
        XCTAssertEqual(location.name, "Foo")
    }
    
    func testInitSetsCoordinates(){
        let coordinate = CLLocationCoordinate2D(latitude: 1,
                                                longitude: 2)
        
        let location = Location(name: "Foo",
                                coordinate: coordinate)
        
        XCTAssertEqual(location.coordinate?.latitude, coordinate.latitude)
        XCTAssertEqual(location.coordinate?.longitude, coordinate.longitude)
        
    }



}
