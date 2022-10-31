//
//  AddProductTypeViewModel.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import Foundation
import CoreData

class AddProductTypeViewModel: ObservableObject {
    private var productId: NSManagedObjectID
    private var productType: ProductType?
    
    @Published var name: String = ""
    @Published var unitType: UnitType = .kg
    
    @Published var unitString: String = ""
    private var unit: Double {
        unitString.toDouble() ?? 0
    }
    
    var isEdit: Bool = false
    
    var isChange: Bool {
        if let type = productType {
            return (
                self.name != type.name ||
                self.unitType != type.unitType ||
                self.unit != type.unit
            )
        }
        
        return false
    }
    
    init(productId: NSManagedObjectID, productTypeVM: ProductTypeViewModel? = nil) {
        self.productId = productId
        
        if let productType = productTypeVM?.productType {
            self.productType = productType
            self.name = productType.name
            self.unitString = productType.unit.splitDigit(maximumFractionDigits: 2)
            isEdit = true
        } else {
            self.productType = ProductType()
        }
    }
    
    func getUnitTitle(unitType: UnitType) -> String {
        unitType.getTitle(by: unit)
    }
    
    //TODO: update data
    
    func save(completion: (ProductType?) -> Void) {
        if !name.isEmpty, !unitString.isEmpty {
            productType?.name = name
            productType?.unitType = unitType
            productType?.unit = unit
            
            if let productCD: ProductCD = ProductCD.byId(id: productId) {
                let productTypeCD = ProductTypeCD.initContext()
                productTypeCD.id  = UUID()
                productTypeCD.name = name
                productTypeCD.unit = unit
                productTypeCD.unitType = unitType.rawValue
                
                productCD.addToProductTypes(productTypeCD)
                
                do {
                    try productTypeCD.save()
                    
                    completion(productType)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
