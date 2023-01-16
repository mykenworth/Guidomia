//
//  CarsViewModel.swift
//  Guidomia-Ken
//
//  Created by Kenworth Nadera on 2023-01-15.
//

import Foundation

class CarsViewModel {
    private let databaseService: APIService
    private var sections: [SectionTypes] = []
    private var filtersMake: [FilterItem] = []
    private var filtersModel: [FilterItem] = []
    private var cars: [Car] = []
    
    init(databaseService: APIService) {
        self.databaseService = databaseService
        sections.append(contentsOf: [.header, .image, .filter])
    }
    
    func getFilters(type: FilterType) -> [FilterItem] {
        switch type {
        case .model:
            return self.filtersModel
        case .make:
            return self.filtersMake
        }
    }
    
    func getUnfilteredSections() -> [SectionTypes] {
        databaseService.getCars { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let cars):
                self.cars = cars
                self.sections.append(.car(models: cars))
                self.filtersMake = cars.map({ FilterItem(text: $0.make, type: .make )})
                self.filtersModel = cars.map({ FilterItem(text: $0.model, type: .model )})
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
        return self.sections
    }
    
    func getFilteredSections(filter: FilterItem) -> [SectionTypes] {
        let filteredCars = self.cars.filter({
            switch filter.type {
            case .make:
                return $0.make == filter.text
            case .model:
                return $0.model == filter.text
            }
        })
        
        for index in 0..<sections.count {
            switch sections[index] {
            case .car:
                sections.remove(at: index)
                sections.append(.car(models: filteredCars))
            default:
                break
            }
        }
        return self.sections
    }
}
