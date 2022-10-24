//
//  AddProductTypeViewModel.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import Foundation

class AddProductTypeViewModel: ObservableObject {
    var type: ProductType?
    
    @Published var name: String = ""
    @Published var unitType: UnitType = .kg
    
    @Published var unitString: String = ""
    private var unit: Double {
        unitString.toDouble() ?? 0
    }
    
    var isEdit: Bool = false
    
    init(type: ProductType? = nil) {
        if let type = type {
            self.type = type
            self.name = type.name
            self.unitString = type.unit.splitDigit(maximumFractionDigits: 2)
            isEdit = true
        } else {
            self.type = ProductType()
        }
    }
    
    func getUnitTitle(unitType: UnitType) -> String {
        unitType.getTitle(by: unit)
    }
    
    func save(completion: (ProductType?) -> Void) {
        if !name.isEmpty, !unitString.isEmpty {
            type?.name = name
            type?.unitType = unitType
            type?.unit = unit
            
            //TODO: save action
            completion(type)
        }
    }
}
