//
//  ProductDetailScreenPriceViewModel.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import Foundation
import CoreData

class ProductDetailScreenPriceViewModel: ObservableObject {
    @Published private var _productTypeVM: ProductTypeViewModel
    @Published private var _productPricesVM: [ProductPriceViewModel] = []
    
    private var _productVM: ProductViewModel? {
        _productTypeVM.getProduct()
    }
    
    var productId: NSManagedObjectID? {
        _productVM?.id
    }
    private var product: Product? {
        _productVM?.product
    }
    
    var productTypeId: NSManagedObjectID {
        _productTypeVM.id
    }
    var productType: ProductType {
        _productTypeVM.productType
    }
    
    var title: String {
        "\(product?.name ?? "") - \(productType.name)"
    }
    var unit: Double {
        productType.unit
    }
    var unitName: String {
        productType.unitType.getTitle(by: unit)
    }
    var productPricesVM: [ProductPriceViewModel] {
        _productPricesVM.sorted(by: { $0.productPrice.updatedAt > $1.productPrice.updatedAt })
    }
    var selectedPriceIndex: Int?
    var selectedPrice: ProductPrice? {
        guard let selectedPriceIndex = selectedPriceIndex, productPricesVM.indices.contains(selectedPriceIndex) else {
            return nil
        }
        return productPricesVM[selectedPriceIndex].productPrice
    }
    var selectedPriceVM: ProductPriceViewModel? {
        guard let selectedPriceIndex = selectedPriceIndex, productPricesVM.indices.contains(selectedPriceIndex) else {
            return nil
        }
        return productPricesVM[selectedPriceIndex]
    }
    
    var lowestPrice: ProductPrice? {
        productType.lowestPrice
    }
    
    init(productTypeVM: ProductTypeViewModel) {
        self._productTypeVM = productTypeVM
    }
    
    func getProductPricesCD() {
        DispatchQueue.main.async {
            self._productPricesVM = self._productTypeVM.getProductPricesVM()
        }
    }
    
    func deleteProductPrice(by id: NSManagedObjectID) {
        if let productPrice: ProductPriceCD = ProductPriceCD.byId(id: id) {
            do {
                try productPrice.delete()
                getProductPricesCD()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteAll() {
        for productPrice in _productPricesVM {
            do {
                try productPrice.delete()
            } catch {
                print(error.localizedDescription)
            }
        }
        getProductPricesCD()
    }
}

struct ProductPriceViewModel {
    let productPriceCD: ProductPriceCD
    
    init(productPriceCD: ProductPriceCD) {
        self.productPriceCD = productPriceCD
    }
    
    var id: NSManagedObjectID {
        productPriceCD.objectID
    }
    
    var store: Store? {
        if let storeCD = productPriceCD.store {
            return StoreViewModel(storeCD: storeCD).store
        }
        return nil
    }
    
    var productPrice: ProductPrice {
        return ProductPrice(
            id: productPriceCD.id ?? UUID(),
            createdAt: productPriceCD.createdAt ?? Date(),
            updatedAt: productPriceCD.updatedAt ?? Date(),
            store: store ?? Store(),
            value: productPriceCD.value,
            date: productPriceCD.date ?? Date()
        )
    }
    
    func delete() throws {
        try productPriceCD.delete()
    }
}
