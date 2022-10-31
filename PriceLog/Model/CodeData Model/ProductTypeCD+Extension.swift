//
//  ProductTypeCD+Extension.swift
//  PriceLog
//
//  Created by William Santoso on 30/10/22.
//

import Foundation
import CoreData

extension ProductTypeCD: BaseModel {
    static func getProductTypes(by productId: NSManagedObjectID) -> [ProductTypeCD] {
        guard let product = ProductCD.byId(id: productId) as? ProductCD,
              let productTypes = product.productTypes
        else {
            return []
        }
        
        return productTypes.allObjects as? [ProductTypeCD] ?? []
    }
}
