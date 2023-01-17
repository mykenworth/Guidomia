//
//  DatabaseServiceMock.swift
//  Guidomia-KenTests
//
//  Created by Kenworth Nadera on 2023-01-16.
//

import Foundation
import UIKit
@testable import Guidomia_Ken

class DatabaseServiceMock: DatabaseService {
    var didGetCarsFromJSON: Bool = false
    var carsFromDatabase = [CarItem]()
    
    let carItems = [
        CarItem(
            consList: ["This car is so fast", "Jame Bond would love to steal that car", "", ""],
            customerPrice: 220000,
            make: "Alpine",
            marketPrice: 110000,
            model: "Roadster",
            prosList: ["Sometime explode"],
            rating: 5),
        CarItem(
            consList: ["You may lose a wheel", "Expensive maintenance"],
            customerPrice: 95000,
            make: "Mercedes Benz",
            marketPrice: 20000,
            model: "GLE coupe",
            prosList: [],
            rating: 5)]
    
    override func getCarsFromJSON(completion: (Result<[CarItem], Error>) -> Void) {
        didGetCarsFromJSON = true
        completion(.success(carItems))
    }
    
    override func getCarsFromDatabase() -> [CarItem] {
        return self.carsFromDatabase
    }
}
