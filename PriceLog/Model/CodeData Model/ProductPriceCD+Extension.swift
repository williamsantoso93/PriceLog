//
//  ProductPriceCD+Extension.swift
//  PriceLog
//
//  Created by William Santoso on 30/10/22.
//

import Foundation
import CoreData

extension ProductPriceCD: BaseModel {
    static func getProductPrice(by productTypeId: NSManagedObjectID) -> [ProductPriceCD] {
        guard let productType = ProductTypeCD.byId(id: productTypeId) as? ProductTypeCD,
              let productPrices = productType.productPrices
        else {
            return []
        }
        
        return productPrices.allObjects as? [ProductPriceCD] ?? []
    }
}
