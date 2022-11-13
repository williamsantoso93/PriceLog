//
//  BrandCD+Extension.swift
//  PriceLog
//
//  Created by William Santoso on 13/11/22.
//

import Foundation
import CoreData

extension BrandCD: BaseModel {
    static func getAllSortedByName() -> [BrandCD] {
        let request: NSFetchRequest<BrandCD> = BrandCD.fetchRequest()
        let sort = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sort]
        
        do {
            return try Self.viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    
}
