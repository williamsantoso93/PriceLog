//
//  ProductTypeViewModel.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import Foundation

class ProductTypeViewModel: ObservableObject {
    private var product: Product
    var productName: String {
        product.name
    }
    @Published var searchText: String = ""
    
    var types: [ProductType] {
        product.types.filter { type in
            searchText.isEmpty ? true : type.name.contains(searchText)
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
        types[Int.random(in: types.indices)].name
    }
    
    
    init(product: Product) {
        self.product = product
    }
}
