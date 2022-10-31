//
//  AddProductViewModel.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import SwiftUI
import CoreData

class AddProductViewModel: ObservableObject {
    private var categoryId: NSManagedObjectID
    private var product: Product?
    
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
    
    init(categoryId: NSManagedObjectID, productVM: ProductViewModel? = nil) {
        self.categoryId = categoryId
        
        if let product = productVM?.product {
            self.product = product
            self.name = product.name
            self.image = product.image
            isEdit = true
        } else {
            self.product = Product()
        }
    }
    
    //TODO: update data
    
    func save(completion: (Product?) -> Void) {
        if !name.isEmpty {
            product?.name = name
            product?.image = image
            
            if let categoryCD: CategoryCD = CategoryCD.byId(id: categoryId) {
                let productCD = ProductCD.initContext()
                productCD.id = UUID()
                productCD.name = name
                
                categoryCD.addToProducts(productCD)
                
                do {
                    try productCD.save()
                } catch {
                    print(error.localizedDescription)
                }
                
                completion(product)
            }
        }
    }
}
