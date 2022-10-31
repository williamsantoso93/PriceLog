//
//  Category.swift
//  PriceLog
//
//  Created by William Santoso on 26/06/22.
//

import Foundation
import UIKit

struct Category: Identifiable {
    var id: UUID = UUID()
    var name: String = ""
    var image: UIImage?
    var products: [Product] = []
}

struct Product: Identifiable {
    var id: UUID = UUID()
    var name: String = ""
    var image: UIImage?
    var types: [ProductType] = []
}

struct ProductType: Identifiable {
    var id: UUID = UUID()
    var name: String = ""
    var image: UIImage?
    var unit: Double = 0
    var unitType: UnitType = .kg
    var code: String?
    var prices: [ProductPrice] = []
    
    var lowestPrice: ProductPrice? {
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
            lowestPrice?.store.name ?? "",
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

struct ProductPrice: Identifiable {
    var id: UUID = UUID()
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
    var store: Store = Store()
    var value: Double = 0
    var date: Date = Date()
    
    var keywords: String {
        [
            store.name,
            String(value),
        ]
        .joinedWithComma()
        .lowercased()
    }
}

struct Store: Identifiable {
    var id: UUID = UUID()
    var name: String = ""
}
