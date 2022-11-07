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
        _productVM.id
    }
    var productVM: ProductViewModel {
        _productVM
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
    var selectedTypeIndex: Int?
    var selectedType: ProductType? {
        guard let selectedTypeIndex = selectedTypeIndex, productTypesVM.indices.contains(selectedTypeIndex) else {
            return nil
        }
        return productTypesVM[selectedTypeIndex].productType
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
            self._productTypesVM = self._productVM.getProductTypesVM()
        }
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
    let productTypeCD: ProductTypeCD
    
    init(productTypeCD: ProductTypeCD) {
        self.productTypeCD = productTypeCD
    }
    
    var id: NSManagedObjectID {
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
            prices: getProductPrices()
        )
    }
    
    var name: String {
        let unit = "\(productType.unit.splitDigit(maximumFractionDigits: 2)) \(productType.unitType.getTitle(by: productType.unit))"
        if productType.name.isEmpty {
            return unit
        }
        return "\(productType.name) - \(unit)"
    }
    
    func delete() throws {
        try productTypeCD.delete()
    }
    
    func getProductPricesVM() -> [ProductPriceViewModel] {
        ProductPriceCD.getProductPrice(by: id).map(ProductPriceViewModel.init)
    }
    
    func getProductPrices() -> [ProductPrice] {
        getProductPricesVM().map { productPriceViewModel in
            productPriceViewModel.productPrice
        }
    }
    
    func getProduct() -> ProductViewModel? {
        guard let productCD = productTypeCD.product else { return nil }
        return ProductViewModel(productCD: productCD)
    }
}
