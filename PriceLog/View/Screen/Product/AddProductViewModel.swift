//
//  AddProductViewModel.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import Foundation

class AddProductViewModel: ObservableObject {
    var product: Product?
    
    @Published var name: String = ""
    
    @Published var categorySelection: Int = 0
    //TODO: change to actual data
    let categories: [String] = [
        "Drink",
        "Food"
    ]
    var isEdit: Bool = false
    
    init(product: Product? = nil) {
        if let product = product {
            self.product = product
            self.name = product.name
            isEdit = true
        } else {
            self.product = Product()
        }
    }
    
    func save(completion: (Product?) -> Void) {
        if !name.isEmpty {
            product?.name = name
            
            //TODO: save action
            completion(product)
        }
    }
}
