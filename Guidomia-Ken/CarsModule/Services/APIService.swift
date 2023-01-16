//
//  DatabaseService.swift
//  Guidomia-Ken
//
//  Created by Kenworth Nadera on 2023-01-15.
//

import Foundation

class APIService {
    func getCars(completion: (Result<[Car], Error>) -> Void) {
        if let url = Bundle.main.url(forResource: "car_list", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Car].self, from: data)
                completion(.success(jsonData))
            } catch let error {
                completion(.failure(error))
            }
        }
    }
}
