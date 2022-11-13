//
//  AddProductViewModel.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import SwiftUI
import CoreData

class AddProductViewModel: ObservableObject {
    private var categoryId: NSManagedObjectID?
    private var brandId: NSManagedObjectID?
    private var productVM: ProductViewModel?
    private var product: Product?
    
    @Published var name: String = ""
    @Published var image: UIImage? = nil
    
    @Published private var _categoriesVM: [CategoryViewModel] = []
    var categoriesVM: [CategoryViewModel] {
        _categoriesVM
    }
    
    @Published private var _brandsVM: [BrandViewModel] = []
    var brandsVM: [BrandViewModel] {
        _brandsVM
    }
    @Published var selectedCategoryVM: CategoryViewModel?
    @Published var selectedCategoryIndex: Int = 0 {
        didSet {
            guard categoriesVM.indices.contains(selectedCategoryIndex) else {
                return
            }
            selectedCategoryVM = categoriesVM[selectedCategoryIndex]
        }
    }
    @Published var selectedBrandVM: BrandViewModel?
    @Published var selectedBrandIndex: Int = 0 {
        didSet {
            guard brandsVM.indices.contains(selectedBrandIndex) else {
                return
            }
            selectedBrandVM = brandsVM[selectedBrandIndex]
        }
    }
    
    var isEdit: Bool = false
    
    var isChange: Bool {
        if let product = product {
            return (
                self.name != product.name ||
                self.image != product.image
            )
        }
        
        return false
    }
    
    init(categoryId: NSManagedObjectID? = nil, brandId: NSManagedObjectID? = nil, productVM: ProductViewModel? = nil) {
        self.categoryId = categoryId
        self.brandId = brandId
        self.productVM = productVM
        
        if let product = productVM?.product {
            self.product = product
            self.name = product.name
            self.image = product.image
            isEdit = true
        } else {
            self.product = Product()
        }
    }
    
    func getDataCD() {
        DispatchQueue.main.async {
            self._categoriesVM = CategoryCD.getAllSortedByName().map(CategoryViewModel.init)
            
            if let categoryId = self.categoryId {
                if let selectedCategoryIndex = self._categoriesVM.firstIndex(where: { categoryVM in
                    categoryId == categoryVM.id
                }) {
                    self.selectedCategoryIndex = selectedCategoryIndex
                }
            } else {
                if self.categoriesVM.indices.contains(self.selectedCategoryIndex) {
                    self.selectedCategoryVM = self.categoriesVM[self.selectedCategoryIndex]
                }
            }
            
            self._brandsVM = BrandCD.getAllSortedByName().map(BrandViewModel.init)
            self.checkNoBrand()
            if let brandId = self.brandId {
                if let selectedBrandIndex = self._brandsVM.firstIndex(where: { brandsVM in
                    brandId == brandsVM.id
                }) {
                    self.selectedBrandIndex = selectedBrandIndex
                }
            } else {
                if self.brandsVM.indices.contains(self.selectedBrandIndex) {
                    self.selectedBrandVM = self.brandsVM[self.selectedBrandIndex]
                }
            }
        }
    }
    
    private func checkNoBrand() {
//        if _brandsVM
    }
    
    func save(completion: () -> Void) {
        if name.isEmpty,
           let brandName = selectedBrandVM?.brand.name {
            name = brandName
        }
        if !name.isEmpty {
            if let categoryId = selectedCategoryVM?.id,
               let categoryCD: CategoryCD = CategoryCD.byId(id: categoryId),
               let brandId = selectedBrandVM?.id,
               let brandCD: BrandCD =  BrandCD.byId(id: brandId) {
                let productCD = getProductCD()
                if !isEdit {
                    productCD.id = UUID()
                }
                productCD.name = name
                
                categoryCD.addToProducts(productCD)
                brandCD.addToProducts(productCD)
                
                do {
                    try productCD.save()
                    completion()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func getProductCD() -> ProductCD {
        if isEdit, let productCD = productVM?.productCD {
            return productCD
        } else {
            return ProductCD.init(context: ProductCD.viewContext)
        }
    }
}
