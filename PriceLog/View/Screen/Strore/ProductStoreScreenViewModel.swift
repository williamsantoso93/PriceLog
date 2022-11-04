//
//  ProductStoreScreenViewModel.swift
//  PriceLog
//
//  Created by William Santoso on 04/11/22.
//

import Foundation
import CoreData

class ProductStoreScreenViewModel: ObservableObject {
    @Published private var _productsVM: [ProductViewModel] = []
    
    var productsVM: [ProductViewModel] {
        _productsVM.filter { productViewModel in
            searchText.isEmpty ? true : productViewModel.product.name.lowercased().contains(searchText.lowercased())
        }
    }
    
    var selectedProductIndex: Int?
    var selectedProduct: Product? {
        guard let selectedProductIndex = selectedProductIndex, productsVM.indices.contains(selectedProductIndex) else {
            return nil
        }
        return productsVM[selectedProductIndex].product
    }
    var selectedProductVM: ProductViewModel? {
        guard let selectedProductVMIndex = selectedProductIndex, productsVM.indices.contains(selectedProductVMIndex) else {
            return nil
        }
        return productsVM[selectedProductVMIndex]
    }
    
    @Published var searchText: String = ""
    var randomSearchPrompt: String {
        productsVM.isEmpty ? "" : productsVM[Int.random(in: productsVM.indices)].product.name
    }
    
    private var _storeVM: StoreViewModel
    
    var storeName: String {
        _storeVM.store.name
    }
    
    init(storeVM: StoreViewModel) {
        self._storeVM = storeVM
    }
    
    func getProductsCD() {
        DispatchQueue.main.async {
            self._productsVM = self._storeVM.getProductsVM()
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
