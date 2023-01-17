//
//  CarsViewModelTests.swift
//  Guidomia-KenTests
//
//  Created by Kenworth Nadera on 2023-01-16.
//

import XCTest
@testable import Guidomia_Ken

class CarsViewModelTests: XCTestCase {
    var sut: CarsViewModel!
    
    let databaseService = DatabaseServiceMock()
    
    override func setUp() {
        super.setUp()
        
        databaseService.carsFromDatabase = databaseService.carItems
        sut = CarsViewModel(databaseService: databaseService)
    }
    
    func testEmptyDatabaseInvokesGetCarsFromJSON() {
        databaseService.carsFromDatabase = []
        sut = CarsViewModel(databaseService: databaseService)
        
        XCTAssertTrue(databaseService.didGetCarsFromJSON, "Initial fetch for car list from JSON invoked.")
    }
    
    func testNonEmptyDatabaseNotGetCarsFromJSON() {
        databaseService.carsFromDatabase = databaseService.carItems
        sut = CarsViewModel(databaseService: databaseService)
        
        XCTAssertFalse(databaseService.didGetCarsFromJSON, "Fetch from JSON not invoked when database entries are available.")
    }
    
    func testUnfilteredSections() {
        let sections = sut.getUnfilteredSections()
        
        XCTAssertTrue(sections.count == 4)
    }
    
    func testFilteredSectionsEmptyText() {
        let unfilteredSections = sut.getUnfilteredSections()
        let filter = FilterItem(text: "", type: .model)
        let sections = sut.getFilteredSections(filter: filter)
        
        XCTAssertTrue(unfilteredSections.count == sections.count, "Empty text filter returns all entries.")
    }
    
    func testFilteredSectionsByModel() {
        let filter = FilterItem(text: "Roadster", type: .model)
        let sections = sut.getFilteredSections(filter: filter)
        
        for section in sections {
            switch section {
            case .car(let models):
                XCTAssertTrue(models.count == 1, "Returns one filter result.")
                XCTAssertTrue(models[0].model == "Roadster", "Should return a CarItem with model Roadster")
            default:
                break
            }
        }
    }
    
    func testFilteredSectionsByMake() {
        let filter = FilterItem(text: "Mercedes Benz", type: .make)
        let sections = sut.getFilteredSections(filter: filter)
        
        for section in sections {
            switch section {
            case .car(let models):
                XCTAssertTrue(models.count == 1, "Returns one filter result.")
                XCTAssertTrue(models[0].make == "Mercedes Benz", "Should return a CarItem with make Mercedes Benz")
            default:
                break
            }
        }
    }
    
    func testGetFiltersByMake() {
        let filters = sut.getFilters(type: .make)
        
        XCTAssertTrue(filters.count == 2, "Should have a make of ['Alpine', 'Mercedes Benz']")
        XCTAssertTrue(filters[0].text == "Alpine")
        XCTAssertTrue(filters[1].text == "Mercedes Benz")
        XCTAssertTrue(filters[0].type == .make)
        XCTAssertTrue(filters[1].type == .make)
    }
    
    func testGetFiltersByModel() {
        let filters = sut.getFilters(type: .model)
        
        XCTAssertTrue(filters.count == 2, "Should have a make of ['Roadster', 'GLE coupe']")
        XCTAssertTrue(filters[0].text == "Roadster")
        XCTAssertTrue(filters[1].text == "GLE coupe")
        XCTAssertTrue(filters[0].type == .model)
        XCTAssertTrue(filters[1].type == .model)
    }
    
}
