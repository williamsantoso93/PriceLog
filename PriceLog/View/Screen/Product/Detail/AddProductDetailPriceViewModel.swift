//
//  AddProductDetailPriceViewModel.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import Foundation
import CoreData

class AddProductDetailPriceViewModel: ObservableObject {
    private var productTypeId: NSManagedObjectID
    private var productPriceVM: ProductPriceViewModel?
    private var productPrice: ProductPrice?
    
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
    
    var isEdit: Bool = false
    
    var isChange: Bool {
        if let productPrice = productPrice {
            return (
                self.priceValue != productPrice.value ||
                self.date != productPrice.date
            )
        }
        
        return false
    }
    
    init(productTypeId: NSManagedObjectID, productPriceVM: ProductPriceViewModel? = nil) {
        self.productTypeId = productTypeId
        self.productPriceVM = productPriceVM
        
        if let productPriceVM = productPriceVM {
            self.productPriceVM = productPriceVM
            self.productPrice = productPriceVM.productPrice
            self.priceString = productPriceVM.productPrice.value.splitDigit(maximumFractionDigits: 2)
            self.date = productPriceVM.productPrice.date
            
            isEdit = true
        }
    }
    
    func getStores() {
        DispatchQueue.main.async {
            self._storesVM = StoreCD.getAllSortedByName().map(StoreViewModel.init)
            
            if self._storesVM.isEmpty {
                self.setInitialStore()
            }
            
            if let productPriceVM = self.productPriceVM,
               let storeId = productPriceVM.store?.id {
                if let selectedStoreIndex = self._storesVM.firstIndex(where: { storeVM in
                    storeId == storeVM.store.id
                }) {
                    self.selectedStoreIndex = selectedStoreIndex
                }
            }
        }
    }
    
    func setInitialStore() {
        let stores: [Store] = [
            Store(name: "Superindo"),
            Store(name: "Indomaret"),
            Store(name: "Food Hall"),
        ]
        
        for store in stores {
            let storeCD = StoreCD.init(context: StoreCD.viewContext)
            
            storeCD.id = store.id
            storeCD.name = store.name
            
            do {
                try storeCD.save()
            } catch {
                print(error.localizedDescription)
            }
        }
        
        getStores()
    }
    
    func save(completion: () -> Void) {
        if !priceString.isEmpty {            
            if let productTypeCD: ProductTypeCD = ProductTypeCD.byId(id: productTypeId) {
                let productPriceCD = getProductPriceCD()
                
                productPriceCD.value = priceValue
                productPriceCD.date = date
                if !isEdit {
                    productPriceCD.id = UUID()
                    productPriceCD.createdAt = Date()
                }
                productPriceCD.updatedAt = Date()
                productPriceCD.store = _storesVM[selectedStoreIndex].storeCD
                
                productTypeCD.addToProductPrices(productPriceCD)
                
                do {
                    try productPriceCD.save()
                    
                    completion()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func getProductPriceCD() -> ProductPriceCD {
        if isEdit, let productPriceCD = productPriceVM?.productPriceCD {
            return productPriceCD
        } else {
            return ProductPriceCD.init(context: ProductPriceCD.viewContext)
        }
    }
}

