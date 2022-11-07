//
//  ProductScreenViewModel.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import Foundation
import CoreData

class ProductScreenViewModel: ObservableObject {
    @Published private var _categoryVM: CategoryViewModel?
    @Published private var _storeVM: StoreViewModel?
    @Published private var _productsVM: [ProductViewModel] = []
    var categoryId: NSManagedObjectID? {
        _categoryVM?.id
    }
    var titleName: String {
        if let _categoryVM = _categoryVM {
            return _categoryVM.category.name
        } else if let _storeVM = _storeVM {
            return _storeVM.store.name
        }
        return "Product"
    }
    var isFullProduct: Bool {
        _categoryVM == nil && _storeVM == nil
    }
    
    @Published var searchText: String = ""
    
    var productsVM: [ProductViewModel] {
        _productsVM.filter { productViewModel in
            searchText.isEmpty ? true : productViewModel.product.name.lowercased().contains(searchText.lowercased())
        }
    }
    
    var selectedProductIndex: Int?
    var selectedProductVM: ProductViewModel? {
        guard let selectedProductVMIndex = selectedProductIndex, productsVM.indices.contains(selectedProductVMIndex) else {
            return nil
        }
        return productsVM[selectedProductVMIndex]
    }
    var randomSearchPrompt: String {
        productsVM.isEmpty ? "" : productsVM[Int.random(in: productsVM.indices)].product.name
    }
    
    init(categoryVM: CategoryViewModel? = nil, storeVM: StoreViewModel? = nil) {
        self._categoryVM = categoryVM
        self._storeVM = storeVM
    }
    
    func getProductsCD() {
        DispatchQueue.main.async {
            if let _categoryVM = self._categoryVM {
                self._productsVM = _categoryVM.getProductsVM()
            } else if let _storeVM = self._storeVM {
                self._productsVM = _storeVM.getProductsVM()
            } else {
                self._productsVM = ProductCD.getAllSortedByName().map(ProductViewModel.init)
            }
        }
    }
    
    func deleteProduct(by id: NSManagedObjectID) {
        if let product: ProductCD = ProductCD.byId(id: id) {
            do {
                try product.delete()
                getProductsCD()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteAll() {
        for product in _productsVM {
            do {
                try product.delete()
            } catch {
                print(error.localizedDescription)
            }
        }
        getProductsCD()
    }
}

struct ProductViewModel {
    let productCD: ProductCD
    
    init(productCD: ProductCD) {
        self.productCD = productCD
    }
    
    var id: NSManagedObjectID {
        productCD.objectID
    }
    
    var product: Product {
        Product(
            id: productCD.id ?? UUID(),
            name: productCD.name ?? "",
            image: nil,
            types: getProductTypes()
        )
    }
    
    func delete() throws {
        try productCD.delete()
    }
    
    func getProductTypesVM() -> [ProductTypeViewModel] {
        ProductTypeCD.getProductTypes(by: id).map(ProductTypeViewModel.init)
    }
    
    func getProductTypes() -> [ProductType] {
        getProductTypesVM().map { productTypeViewModel in
            productTypeViewModel.productType
        }
    }
}
