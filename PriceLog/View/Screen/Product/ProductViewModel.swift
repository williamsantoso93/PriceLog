//
//  ProductViewModel.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import Foundation

class ProductViewModel: ObservableObject {
    @Published var category: Category
    var products: [Product] {
        category.products
    }
    var selectedProductIndex: Int?
    var selectedProduct: Product? {
        guard let selectedProductIndex = selectedProductIndex, products.indices.contains(selectedProductIndex) else {
            return nil
        }
        return products[selectedProductIndex]
    }
    
    init(category: Category) {
        self.category = category
    }
    
    func setSavedProduct(product: Product) {
        if let selectedProductIndex = selectedProductIndex, products.indices.contains(selectedProductIndex) {
            category.products[selectedProductIndex] = product
        } else {
            category.products.append(product)
        }
    }
    
    func deleteProduct() {
        guard let selectedProductIndex = selectedProductIndex, category.products.indices.contains(selectedProductIndex) else {
            return
        }
        
        category.products.remove(at: selectedProductIndex)
    }
}
