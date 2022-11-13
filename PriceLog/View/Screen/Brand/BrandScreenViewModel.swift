//
//  BrandScreenViewModel.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import Foundation
import CoreData

class BrandScreenViewModel: ObservableObject {
    @Published private var _brandsVM: [BrandViewModel] = []
    private var _brands: [Brand] {
        _brandsVM.map { brandViewModel in
            brandViewModel.brand
        }
    }
    
    @Published var searchText: String = ""
    
    var brandsVM: [BrandViewModel] {
        _brandsVM.filter { brandViewModel in
            searchText.isEmpty ? true : brandViewModel.brand.name.lowercased().contains(searchText.lowercased())
        }
    }
    
    var selectedBrandIndex: Int?
    var selectedBrand: Brand? {
        guard let selectedBrandIndex = selectedBrandIndex, brandsVM.indices.contains(selectedBrandIndex) else {
            return nil
        }
        return brandsVM[selectedBrandIndex].brand
    }
    var selectedBrandVM: BrandViewModel? {
        guard let selectedBrandVMIndex = selectedBrandIndex, brandsVM.indices.contains(selectedBrandVMIndex) else {
            return nil
        }
        return brandsVM[selectedBrandVMIndex]
    }
    var randomSearchPrompt: String {
        _brands.isEmpty ? "" : _brands[Int.random(in: _brands.indices)].name
    }
    
    func getBrandsCD() {
        DispatchQueue.main.async {
            self._brandsVM = BrandCD.getAllSortedByName().map(BrandViewModel.init)
        }
    }
    
    func deleteBrand(by id: NSManagedObjectID) {
        if let brand: BrandCD = BrandCD.byId(id: id) {
            do {
                try brand.delete()
                getBrandsCD()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteAll() {
        for brand in _brandsVM {
            do {
                try brand.delete()
            } catch {
                print(error.localizedDescription)
            }
        }
        getBrandsCD()
    }
}

struct BrandViewModel: Hashable, Identifiable {
    let brandCD: BrandCD
    
    init(brandCD: BrandCD) {
        self.brandCD = brandCD
    }
    
    var id: NSManagedObjectID {
        brandCD.objectID
    }
    
    var brand: Brand {
        Brand(
            id: brandCD.id ?? UUID(),
            name: brandCD.name ?? "",
            products: []
        )
    }
    
    func delete() throws {
        try brandCD.delete()
    }
    
    func getProductsVM() -> [ProductViewModel] {
        ProductCD.getProductsBy(brandId: id).map(ProductViewModel.init)
    }
}
