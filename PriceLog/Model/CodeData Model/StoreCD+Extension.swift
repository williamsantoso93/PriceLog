//
//  StoreCD+Extension.swift
//  PriceLog
//
//  Created by William Santoso on 30/10/22.
//

import Foundation
import CoreData

extension StoreCD: BaseModel {
    static func getAllSortedByName() -> [StoreCD] {
        let request: NSFetchRequest<StoreCD> = StoreCD.fetchRequest()
        let sort = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sort]
        
        do {
            return try Self.viewContext.fetch(request)
        } catch {
            return []
        }
    }
}

