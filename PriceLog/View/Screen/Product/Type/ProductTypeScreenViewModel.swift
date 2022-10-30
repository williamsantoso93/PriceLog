//
//  ProductTypeScreenViewModel.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import Foundation
import CoreData

class ProductTypeScreenViewModel: ObservableObject {
    @Published private var _productVM: ProductViewModel
    @Published private var _productTypesVM: [ProductTypeViewModel] = []
    var productId: NSManagedObjectID {
        _productVM.productID
    }
    var product: Product {
        _productVM.product
    }
    var productName: String {
        product.name
    }
    
    @Published var searchText: String = ""
    var productTypesVM: [ProductTypeViewModel] {
        _productTypesVM.filter { productTypeViewModel in
            searchText.isEmpty ? true : productTypeViewModel.productType.keywords.contains(searchText.lowercased())
        }
    }
    var types: [(id: NSManagedObjectID, productType: ProductType)] {
        productTypesVM.map { productTypeViewModel in
            (productTypeViewModel.productTypeID, productTypeViewModel.productType)
        }
    }
    var selectedTypeIndex: Int?
    var selectedType: ProductType? {
        guard let selectedTypeIndex = selectedTypeIndex, types.indices.contains(selectedTypeIndex) else {
            return nil
        }
        return types[selectedTypeIndex].productType
    }
    var selectedTypeVM: ProductTypeViewModel? {
        guard let selectedProductTypeIndex = selectedTypeIndex, productTypesVM.indices.contains(selectedProductTypeIndex) else {
            return nil
        }
        return productTypesVM[selectedProductTypeIndex]
    }
    var randomSearchPrompt: String {
        product.types.isEmpty ? "" : product.types[Int.random(in: product.types.indices)].name
    }
    
    init(productVM: ProductViewModel) {
        self._productVM = productVM
    }
    
    func getProductTypesCD() {
        DispatchQueue.main.async {
            self._productTypesVM = self._productVM.getProductTypes()
        }
    }
    
    func setSavedType(type: ProductType) {
//        if let selectedTypeIndex = selectedTypeIndex, types.indices.contains(selectedTypeIndex) {
//            product.types[selectedTypeIndex] = type
//        } else {
//            product.types.append(type)
//        }
    }
    
    func deleteType() {
//        guard let selectedTypeIndex = selectedTypeIndex, product.types.indices.contains(selectedTypeIndex) else {
//            return
//        }
//
//        product.types.remove(at: selectedTypeIndex)
    }
    
    func deleteProductType(by id: NSManagedObjectID) {
        if let productType: ProductTypeCD = ProductTypeCD.byId(id: id) {
            do {
                try productType.delete()
                getProductTypesCD()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteAll() {
        for productType in _productTypesVM {
            do {
                try productType.delete()
            } catch {
                print(error.localizedDescription)
            }
        }
        getProductTypesCD()
    }
}

struct ProductTypeViewModel {
    private let productTypeCD: ProductTypeCD
    
    init(productTypeCD: ProductTypeCD) {
        self.productTypeCD = productTypeCD
    }
    
    var productTypeID: NSManagedObjectID {
        productTypeCD.objectID
    }
    
    var productType: ProductType {
        ProductType(
            id: productTypeCD.id ?? UUID(),
            name: productTypeCD.name ?? "",
            image: nil,
            unit: productTypeCD.unit,
            unitType: UnitType(rawValue: productTypeCD.unitType ?? "") ?? .kg,
            code: productTypeCD.code,
            prices: []
        )
    }
    
    func delete() throws {
        try productTypeCD.delete()
    }
}
