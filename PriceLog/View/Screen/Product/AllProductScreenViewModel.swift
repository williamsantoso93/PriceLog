//
//  AllProductScreenViewModel.swift
//  PriceLog
//
//  Created by William Santoso on 04/11/22.
//

import Foundation
import CoreData

class AllProductScreenViewModel: ObservableObject {
    @Published private var _productsVM: [ProductViewModel] = []
    @Published var searchText: String = ""
    var categoryId: NSManagedObjectID?  = nil
    
    var productsVM: [ProductViewModel] {
        _productsVM.filter { productViewModel in
            searchText.isEmpty ? true : productViewModel.product.name.lowercased().contains(searchText.lowercased())
        }
    }
    var products: [(id: NSManagedObjectID, product: Product)] {
        productsVM.map { productViewModel in
            (productViewModel.id, productViewModel.product)
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
        products.isEmpty ? "" : products[Int.random(in: products.indices)].product.name
    }
    
    func getProductsCD() {
        DispatchQueue.main.async {
            self._productsVM = ProductCD.getAllSortedByName().map(ProductViewModel.init)
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
