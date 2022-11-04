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
    
    static func getProductsBy(categoryId: NSManagedObjectID) -> [ProductCD] {
        guard let category = CategoryCD.byId(id: categoryId) as? CategoryCD,
              let products = category.products
        else {
            return []
        }
        
        return products.allObjects as? [ProductCD] ?? []
    }
    
    static func getProductsBy(storeId: NSManagedObjectID) -> [ProductCD] {
        guard let storeCD = StoreCD.byId(id: storeId) as? StoreCD,
              let productPricesCD = storeCD.productPrices
        else {
            return []
        }
        
        var productsCD: [ProductCD] = []
        
        if let productPricesCD = productPricesCD.allObjects as? [ProductPriceCD] {
            for productPriceCD in productPricesCD {
                if let productTypeCD = productPriceCD.productType {
                    if let productCD = productTypeCD.product {
                        productsCD.append(productCD)
                    }
                }
            }
        }
        
        return productsCD
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
