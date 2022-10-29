//
//  AddProductViewModel.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import SwiftUI

class AddProductViewModel: ObservableObject {
    var product: Product?
    
    @Published var name: String = ""
    @Published var image: UIImage? = nil
    
    @Published var categorySelection: Int = 0
    //TODO: change to actual data
    let categories: [String] = [
        "Drink",
        "Food"
    ]
    var isEdit: Bool = false
    
    var isChange: Bool {
        if let product = product {
            return (
                self.name != product.name ||
                self.image != product.image
            )
        }
        
        return false
    }
    
    init(product: Product? = nil) {
        if let product = product {
            self.product = product
            self.name = product.name
            self.image = product.image
            isEdit = true
        } else {
            self.product = Product()
        }
    }
    
    func save(completion: (Product?) -> Void) {
        if !name.isEmpty {
            product?.name = name
            product?.image = image
            
            //TODO: save action
            completion(product)
        }
    }
}
