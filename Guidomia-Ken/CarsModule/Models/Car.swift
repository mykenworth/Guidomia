//
//  Car.swift
//  Guidomia-Ken
//
//  Created by Kenworth Nadera on 2023-01-15.
//

import Foundation

struct Car: Codable {
    var consList: [String]
    var customerPrice: Double
    var make: String
    var marketPrice: Double
    var model: String
    var prosList: [String]
    var rating: Int
    
    enum CodingKeys: String, CodingKey {
        case consList, customerPrice, make, marketPrice, model, prosList, rating
    }
}
