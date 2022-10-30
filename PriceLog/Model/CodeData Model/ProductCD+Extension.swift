//
//  ProductCD+Extension.swift
//  PriceLog
//
//  Created by William Santoso on 29/10/22.
//

import Foundation
import CoreData

extension ProductCD: BaseModel {
    static func getProducts(by categoryID: NSManagedObjectID) -> [ProductCD] {
        guard let category = CategoryCD.byId(id: categoryID) as? CategoryCD,
              let products = category.products
        else {
            return []
        }
        
        return products.allObjects as? [ProductCD] ?? []
    }
    
//    static func getActorsByMovieId(movieId: NSManagedObjectID) -> [Actor] {
//        guard let movie = Movie.byId(id: movieId) as? Movie,
//              let actors = movie.actors
//        else {
//            return []
//        }
//
//        return (actors.allObjects as? [Actor]) ?? []
//    }
}
