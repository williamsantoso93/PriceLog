//
//  ProductCD+Extension.swift
//  PriceLog
//
//  Created by William Santoso on 29/10/22.
//

import Foundation
import CoreData

extension ProductCD: BaseModel {
    static func getProducts(by categoryId: NSManagedObjectID) -> [ProductCD] {
        guard let category = CategoryCD.byId(id: categoryId) as? CategoryCD,
              let products = category.products
        else {
            return []
        }
        
        return products.allObjects as? [ProductCD] ?? []
    }
}
