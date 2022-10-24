//
//  ProductDetailPriceViewModel.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import Foundation

class ProductDetailPriceViewModel: ObservableObject {
    @Published private var product: Product
    private var selectedTypeIndex: Int
    var selectedType: ProductType {
        product.types[selectedTypeIndex]
    }
    
    var title: String {
        "\(product.name) - \(selectedType.name)"
    }
    var unit: Double {
        selectedType.unit
    }
    var unitName: String {
        selectedType.unitType.getTitle(by: unit)
    }
    
    var prices: [Price] {
        product.types[selectedTypeIndex].prices.sorted(by: { $0.updatedDate > $1.updatedDate })
    }
    var selectedPriceIndex: Int?
    var selectedPrice: Price? {
        guard let selectedPriceIndex = selectedPriceIndex, prices.indices.contains(selectedPriceIndex) else {
            return nil
        }
        return prices[selectedPriceIndex]
    }
    
    var lowestPrice: Price? {
        selectedType.lowestPrice
    }
    
    init(product: Product, selectedTypeIndex: Int) {
        self.product = product
        self.selectedTypeIndex = selectedTypeIndex
    }
    
    func setSavedPrice(price: Price) {
        if let selectedPriceIndex = selectedPriceIndex, prices.indices.contains(selectedPriceIndex) {
            product.types[selectedTypeIndex].prices[selectedPriceIndex] = price
        } else {
            product.types[selectedTypeIndex].prices.append(price)
        }
    }
    
    func deletePrice() {
        guard let selectedPriceIndex = selectedPriceIndex, product.types.indices.contains(selectedPriceIndex) else {
            return
        }
        
        product.types.remove(at: selectedPriceIndex)
    }
}
