//
//  ProductScreenViewModel.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import Foundation
import CoreData

class ProductScreenViewModel: ObservableObject {
    @Published private var _categoryVM: CategoryViewModel
    @Published private var _productsVM: [ProductViewModel] = []
    var categoryId: NSManagedObjectID {
        _categoryVM.categoryID
    }
    var category: Category {
        _categoryVM.category
    }
    var categoryName: String {
        category.name
    }
    
    @Published var searchText: String = ""
    
    var productsVM: [ProductViewModel] {
        _productsVM.filter { productViewModel in
            searchText.isEmpty ? true : productViewModel.product.name.lowercased().contains(searchText.lowercased())
        }
    }
    var products: [(id: NSManagedObjectID, product: Product)] {
        productsVM.map { productViewModel in
            (productViewModel.productID, productViewModel.product)
        }
    }
                    
    var selectedProductIndex: Int?
    var selectedProduct: Product? {
        guard let selectedProductIndex = selectedProductIndex, products.indices.contains(selectedProductIndex) else {
            return nil
        }
        return products[selectedProductIndex].product
    }
    var selectedProductVM: ProductViewModel? {
        guard let selectedProductVMIndex = selectedProductIndex, productsVM.indices.contains(selectedProductVMIndex) else {
            return nil
        }
        return productsVM[selectedProductVMIndex]
    }
    var randomSearchPrompt: String {
        category.products.isEmpty ? "" : category.products[Int.random(in: category.products.indices)].name
    }
    
    init(categoryVM: CategoryViewModel) {
        self._categoryVM = categoryVM
    }
    
    func getProductsCD() {
        DispatchQueue.main.async {
            self._productsVM = self._categoryVM.getProducts()
        }
    }
    
    func setSavedProduct(product: Product) {
//        if let selectedProductIndex = selectedProductIndex, products.indices.contains(selectedProductIndex) {
//            category.products[selectedProductIndex] = product
//        } else {
//            category.products.append(product)
//        }
    }
    
    func deleteProduct() {
//        guard let selectedProductIndex = selectedProductIndex, category.products.indices.contains(selectedProductIndex) else {
//            return
//        }
        
//        category.products.remove(at: selectedProductIndex)
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
        for product in productsVM {
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
    private let productCD: ProductCD
    
    init(productCD: ProductCD) {
        self.productCD = productCD
    }
    
    var productID: NSManagedObjectID {
        productCD.objectID
    }
    
    var product: Product {
        Product(
            id: productCD.id ?? UUID(),
            name: productCD.name ?? "",
            image: nil,
            types: []
        )
    }
    
    func delete() throws {
        try productCD.delete()
    }
}
