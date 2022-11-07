//
//  AddFullProductViewModel.swift
//  PriceLog
//
//  Created by William Santoso on 07/11/22.
//

import Foundation
import CoreData

class AddFullProductViewModel: ObservableObject {
    //MARK: - Product
    @Published var productName: String = ""
    
    @Published var selectedProductIndex: Int = 0 {
        didSet {
            getProductTypes()
        }
    }
    @Published private var _productsVM: [ProductViewModel] = []
    var productsVM: [ProductViewModel] {
        _productsVM
    }
    var selectedProductId: NSManagedObjectID {
        _productsVM[selectedProductIndex].id
    }
    
    var isChange: Bool {
        selectedProductIndex != 0 ||
        selectedProductTypeIndex != 0 ||
        !priceString.isEmpty
    }
    
    func getData() {
        getProducts()
        getProductTypes()
        getStores()
    }
    
    private func getProducts() {
        self._productsVM = ProductCD.getAllSortedByName().map(ProductViewModel.init)
    }
    
    func save(completion: () -> Void) {
        guard !productsVM.isEmpty && !productTypesVM.isEmpty && !storesVM.isEmpty && !priceString.isEmpty else { return }
        
        let productTypeCD = productTypesVM[selectedProductTypeIndex].productTypeCD
        
        let productPriceCD = ProductPriceCD.init(context: ProductPriceCD.viewContext)
        
        productPriceCD.value = priceValue
        productPriceCD.date = date
        productPriceCD.id = UUID()
        productPriceCD.createdAt = Date()
        productPriceCD.updatedAt = Date()
        productPriceCD.store = storesVM[selectedStoreIndex].storeCD
        
        productTypeCD.addToProductPrices(productPriceCD)
        
        do {
            try productPriceCD.save()
            
            completion()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //MARK: - Type
    @Published var typeName: String = ""
    @Published var unitType: UnitType = .kg
    
    @Published var unitString: String = ""
    private var unit: Double {
        unitString.toDouble() ?? 0
    }
    
    func getUnitTitle(unitType: UnitType) -> String {
        unitType.getTitle(by: unit)
    }
    
    @Published var selectedProductTypeIndex: Int = 0
    @Published private var _productTypesVM: [ProductTypeViewModel] = []
    var productTypesVM: [ProductTypeViewModel] {
        _productTypesVM
    }
    
    private func getProductTypes() {
        DispatchQueue.main.async {
            guard self._productsVM.indices.contains(self.selectedProductIndex) else { return }
            
            self._productTypesVM = self._productsVM[self.selectedProductIndex].getProductTypesVM()
        }
    }
    
    //MARK: - Price
    @Published var priceString: String = ""
    private var priceValue: Double {
        priceString.toDouble() ?? 0
    }
    
    @Published var selectedStoreIndex: Int = 0
    @Published private var _storesVM: [StoreViewModel] = []
    var storesVM: [StoreViewModel] {
        _storesVM
    }
    
    @Published var date: Date = Date()
    
    private func getStores() {
        DispatchQueue.main.async {
            self._storesVM = StoreCD.getAllSortedByName().map(StoreViewModel.init)
        }
    }
}
