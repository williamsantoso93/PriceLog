//
//  Category.swift
//  PriceLog
//
//  Created by William Santoso on 26/06/22.
//

import Foundation

struct Category: Identifiable {
    var id: UUID = UUID()
    var name: String
    var image: String //TODO: change type
    var products: [Product]
}

struct Product: Identifiable {
    var id: UUID = UUID()
    var name: String
    var image: String //TODO: change type
    var types: [ProductType]
}

struct ProductType: Identifiable {
    var id: UUID = UUID()
    var name: String
    var image: String //TODO: change type
    var unit: Int
    var unitType: UnitType
    var prices: [Price]
    
    var lowestPrice: Price? {
        prices.sorted {
            $0.value < $1.value
        }.first
    }
}

enum UnitType: String {
    case kg = "Kg"
    case g = "g"
    case m = "mtr"
    case pax = "pax"
    case ml = "ml"
    case l = "l"
}

struct Price: Identifiable {
    var id: UUID = UUID()
    var createdDate: Date
    var updatedDate: Date
    var place: Place
    var value: Double
}

struct Place: Identifiable {
    var id: UUID = UUID()
    var name: String
}
