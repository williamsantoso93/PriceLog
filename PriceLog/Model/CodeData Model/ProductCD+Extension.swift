//
//  ProductCD+Extension.swift
//  PriceLog
//
//  Created by William Santoso on 29/10/22.
//

import Foundation
import CoreData

extension ProductCD: BaseModel {
    static func getAllSortedByName() -> [ProductCD] {
        let request: NSFetchRequest<ProductCD> = ProductCD.fetchRequest()
        let sort = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sort]
        
        do {
            return try Self.viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    static func getProducts(by categoryId: NSManagedObjectID) -> [ProductCD] {
        guard let category = CategoryCD.byId(id: categoryId) as? CategoryCD,
              let products = category.products
        else {
            return []
        }
        
        return products.allObjects as? [ProductCD] ?? []
    }
    
    static func getByProductType(by productTypeId: NSManagedObjectID) -> ProductCD? {
        guard let productType = ProductTypeCD.byId(id: productTypeId) as? ProductTypeCD,
              let productId = productType.product?.objectID
        else {
            return nil
        }
        
        return ProductCD.byId(id: productId)
    }
}
