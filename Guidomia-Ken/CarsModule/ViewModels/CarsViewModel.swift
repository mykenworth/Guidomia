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
    
    init(databaseService: APIService) {
        self.databaseService = databaseService
        sections.append(contentsOf: [.header, .image])
    }
    
    func getItems() -> [SectionTypes] {
        databaseService.getCars { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let cars):
                self.sections.append(.car(models: cars))
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
        return self.sections
    }
}
