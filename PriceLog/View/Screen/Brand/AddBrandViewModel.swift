//
//  AddBrandViewModel.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import Foundation

class AddBrandViewModel: ObservableObject {
    var brandVM: BrandViewModel?
    var brand: Brand?
    
    @Published var name: String = ""
    
    var isEdit: Bool = false
    
    var isChange: Bool {
        if let name = brand?.name {
            return self.name != name
        }
        
        return false
    }
    
    init(brandVM: BrandViewModel? = nil) {
        self.brandVM = brandVM
        if let brand = brandVM?.brand {
            self.brand = brand
            self.name = brand.name
            isEdit = true
        } else {
            self.brand = Brand()
        }
    }
    
    func save(completion: () -> Void) {
        if !name.isEmpty {
            let brandCD = getBrandCD()
            if !isEdit {
                brandCD.id = UUID()
            }
            brandCD.name = name
            
            do {
                try brandCD.save()
                
                completion()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func getBrandCD() -> BrandCD {
        if isEdit, let brandCD = brandVM?.brandCD {
            return brandCD
        } else {
            return BrandCD.init(context: BrandCD.viewContext)
        }
    }
}
