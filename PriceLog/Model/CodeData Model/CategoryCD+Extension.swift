//
//  Catalog+Extension.swift
//  PriceLog
//
//  Created by William Santoso on 29/10/22.
//

import Foundation
import CoreData

extension CategoryCD: BaseModel {
    static func getAllSortedByName() -> [CategoryCD] {
        let request: NSFetchRequest<CategoryCD> = CategoryCD.fetchRequest()
        let sort = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sort]
        
        do {
            return try Self.viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
}
