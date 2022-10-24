//
//  Category.swift
//  PriceLog
//
//  Created by William Santoso on 26/06/22.
//

import Foundation

struct Category: Identifiable {
    var id: UUID = UUID()
    var name: String = ""
    var image: String? //TODO: change type
    var products: [Product] = []
}

struct Product: Identifiable {
    var id: UUID = UUID()
    var name: String = ""
    var image: String? //TODO: change type
    var types: [ProductType] = []
}

struct ProductType: Identifiable {
    var id: UUID = UUID()
    var name: String = ""
    var image: String? //TODO: change type
    var unit: Double = 0
    var unitType: UnitType = .kg
    var prices: [Price] = []
    
    var lowestPrice: Price? {
        prices.sorted {
            $0.value < $1.value
        }.first
    }
    
    var keywords: String {
        [
            name,
            String(unit),
            unitType.getTitle(by: Double(unit)),
            String(lowestPrice?.value ?? 0),
            lowestPrice?.place.name ?? "",
        ]
        .joinedWithComma()
        .lowercased()
    }
}

enum UnitType: String, CaseIterable {
    case kg
    case g
    case m
    case pax
    case ml
    case l
    case pc
    case unit
    case set
    
    func getTitle(by value: Double = 0) -> String {
        var tempTitle = self.rawValue
        switch self {
        case .m:
            tempTitle = "mtr"
        case .kg, .pax, .l, .pc, .unit, .set:
            tempTitle = tempTitle.capitalized(with: nil)
        default:
            break
        }
        
        let isNeedPrural = value > 1
        switch self {
        case .pc, .unit, .set:
            tempTitle = "\(tempTitle)\(isNeedPrural ? "s" : "")"
        default:
            break
        }
        
        return tempTitle
    }
    
    func getValueTitle() -> String {
        switch self {
        case .pax, .pc, .unit, .set:
            return "Qty"
        default:
            return "Weight"
        }
    }
}

struct Price: Identifiable {
    var id: UUID = UUID()
    var createdDate: Date
    var updatedDate: Date
    var place: Place
    var value: Double
    
    var keywords: String {
        [
            place.name,
            String(value),
        ]
        .joinedWithComma()
        .lowercased()
    }
}

struct Place: Identifiable {
    var id: UUID = UUID()
    var name: String
}
