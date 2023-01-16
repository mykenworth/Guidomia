//
//  FilterItem.swift
//  Guidomia-Ken
//
//  Created by Kenworth Nadera on 2023-01-16.
//

import Foundation

struct FilterItem {
    let text: String
    let type: FilterType
}

enum FilterType {
    case model
    case make
}
