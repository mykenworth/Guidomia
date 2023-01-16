//
//  CarsViewModel.swift
//  Guidomia-Ken
//
//  Created by Kenworth Nadera on 2023-01-15.
//

import Foundation

class CarsViewModel {
    private var sections: [CarsVCSectionTypes] = []
    
    init() {
        sections.append(contentsOf: [.header, .image, .car, .car, .car, .car, .car, .car, .car])
    }
    
    func getItems() -> [CarsVCSectionTypes] {
        return sections
    }
}
