//
//  ProductTypeViewModel.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import Foundation

class ProductTypeViewModel: ObservableObject {
    @Published private var product: Product
    var productName: String {
        product.name
    }
    @Published var searchText: String = ""
    
    var types: [ProductType] {
        product.types.filter { type in
            searchText.isEmpty ? true : type.keywords.contains(searchText.lowercased())
        }
    }
    var selectedTypeIndex: Int?
    var selectedType: ProductType? {
        guard let selectedTypeIndex = selectedTypeIndex, types.indices.contains(selectedTypeIndex) else {
            return nil
        }
        return types[selectedTypeIndex]
    }
    var randomSearchPrompt: String {
        product.types[Int.random(in: product.types.indices)].name
    }
    
    init(product: Product) {
        self.product = product
    }
    
    func setSavedType(type: ProductType) {
        if let selectedTypeIndex = selectedTypeIndex, types.indices.contains(selectedTypeIndex) {
            product.types[selectedTypeIndex] = type
        } else {
            product.types.append(type)
        }
    }
    
    func deleteType() {
        guard let selectedTypeIndex = selectedTypeIndex, product.types.indices.contains(selectedTypeIndex) else {
            return
        }
        
        product.types.remove(at: selectedTypeIndex)
    }
}
