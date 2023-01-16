//
//  CarsViewModel.swift
//  Guidomia-Ken
//
//  Created by Kenworth Nadera on 2023-01-15.
//

import Foundation

class CarsViewModel {
    private let databaseService: DatabaseService
    private var sections: [SectionType] = []
    private var filtersMake: [FilterItem] = []
    private var filtersModel: [FilterItem] = []
    private var cars: [CarItem] = []
    
    init(databaseService: DatabaseService) {
        self.databaseService = databaseService
        
        // default sections
        sections.append(contentsOf: [.header, .image, .filter])
        
        // fetch from Database or JSON, whichever is appropriate
        loadCollection()
    }
    
    private func loadCollection() {
        // fetch from database first
        let carsFromDatabase = databaseService.getCarsFromDatabase()
        
        // use JSON objects if no database entries found
        if (carsFromDatabase.isEmpty) {
            databaseService.getCarsFromJSON { [weak self] result in
                switch result {
                case .success(let cars):
                    self?.setSelections(with: cars)
                    
                    // save to database
                    self?.databaseService.saveCarsToDatabase(cars: cars)
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                }
            }
        } else {
            setSelections(with: carsFromDatabase)
        }
    }
    
    // MARK: Getters
    func getUnfilteredSections() -> [SectionType] {
        return self.sections
    }
    
    func getFilteredSections(filter: FilterItem) -> [SectionType] {
        if (filter.text.isEmpty) {
            return self.sections
        }
        
        // establish the filtered car collection
        let filteredCars = self.cars.filter({
            switch filter.type {
            case .make:
                return $0.make == filter.text
            case .model:
                return $0.model == filter.text
            }
        })
        
        var filteredSections = self.sections
        // refresh the sections
        for index in 0..<filteredSections.count {
            switch filteredSections[index] {
            case .car:
                filteredSections.remove(at: index)
                filteredSections.append(.car(models: filteredCars))
            default:
                break
            }
        }
        
        return filteredSections
    }
    
    func getFilters(type: FilterType) -> [FilterItem] {
        // returns an array of FilterItems used for FilterCell
        switch type {
        case .model:
            return self.filtersModel
        case .make:
            return self.filtersMake
        }
    }
    
    private func setSelections(with cars: [CarItem]) {
        self.cars = cars
        self.sections.append(.car(models: cars))
        self.filtersMake = cars.map({ FilterItem(text: $0.make, type: .make )})
        self.filtersModel = cars.map({ FilterItem(text: $0.model, type: .model )})
    }
}
