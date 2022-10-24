//
//  ProductViewModel.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import Foundation

class ProductViewModel: ObservableObject {
    @Published var category: Category
    var categoryName: String {
        category.name
    }
    var products: [Product] {
        category.products.filter { product in
            searchText.isEmpty ? true : product.name.contains(searchText)
        }
    }
    var selectedProductIndex: Int?
    var selectedProduct: Product? {
        guard let selectedProductIndex = selectedProductIndex, products.indices.contains(selectedProductIndex) else {
            return nil
        }
        return products[selectedProductIndex]
    }
    var randomSearchPrompt: String {
        products[Int.random(in: products.indices)].name
    }
    
    @Published var searchText: String = ""
    
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
