//
//  DatabaseService.swift
//  Guidomia-Ken
//
//  Created by Kenworth Nadera on 2023-01-15.
//

import Foundation
import CoreData
import UIKit

class DatabaseService {
    // MARK: GET Methods
    func getCarsFromJSON(completion: (Result<[CarItem], Error>) -> Void) {
        if let url = Bundle.main.url(forResource: "car_list", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([CarItem].self, from: data)
                completion(.success(jsonData))
            } catch let error {
                completion(.failure(error))
            }
        }
    }
    
    func getCarsFromDatabase() -> [CarItem] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: String(describing: Car.self))
        
        var cars = [CarItem]()
        do {
            let carContexts = try context.fetch(fetchRequest) as? [Car] ?? []
            for carContext in carContexts {
                let car = CarItem(
                    consList: carContext.consList?.components(separatedBy: ",") ?? [],
                    customerPrice: carContext.customerPrice,
                    make: carContext.make!,
                    marketPrice: carContext.marketPrice,
                    model: carContext.model!,
                    prosList: carContext.prosList?.components(separatedBy: ",") ?? [],
                    rating: Int(carContext.rating)
                )
                cars.append(car)
            }
        } catch let error as NSError {
            cars = []
            debugPrint(error.localizedDescription)
        }
        
        return cars
    }
    
    // MARK: Save Methods
    func saveCarsToDatabase(cars: [CarItem]) {
        // fetch the context
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        // fetch the entity
        guard let entity = NSEntityDescription.entity(forEntityName: String(describing: Car.self), in: context) else { return }
        
        for car in cars {
            // create the entity
            let carEntity = NSManagedObject(entity: entity, insertInto: context)
            carEntity.setValue(car.customerPrice, forKey: "customerPrice")
            carEntity.setValue(car.make, forKey: "make")
            carEntity.setValue(car.model, forKey: "model")
            carEntity.setValue(car.marketPrice, forKey: "marketPrice")
            carEntity.setValue(car.rating, forKey: "rating")
            carEntity.setValue(car.prosList.joined(separator: ","), forKey: "prosList")
            carEntity.setValue(car.consList.joined(separator: ","), forKey: "consList")
            
            // save to database
            do {
                try context.save()
            } catch let error as NSError {
                debugPrint(error.localizedDescription)
            }
        }
    }
}
