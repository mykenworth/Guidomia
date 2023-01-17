//
//  SectionType.swift
//  Guidomia-Ken
//
//  Created by Kenworth Nadera on 2023-01-16.
//

import Foundation

enum SectionType {
    case header
    case filter
    case image
    case car(models: [CarItem])
}
