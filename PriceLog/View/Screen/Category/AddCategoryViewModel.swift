//
//  AddCategoryViewModel.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import Foundation

class AddCategoryViewModel: ObservableObject {
    var categoryVM: CategoryViewModel?
    var category: Category?
    
    @Published var name: String = ""
    
    var isEdit: Bool = false
    
    var isChange: Bool {
        if let name = category?.name {
            return self.name != name
        }
        
        return false
    }
    
    init(categoryVM: CategoryViewModel? = nil) {
        self.categoryVM = categoryVM
        if let category = categoryVM?.category {
            self.category = category
            self.name = category.name
            isEdit = true
        } else {
            self.category = Category()
        }
    }
    
    func save(completion: () -> Void) {
        if !name.isEmpty {
            let categoryCD = getCategoryCD()
            if !isEdit {
                categoryCD.id = UUID()
            }
            categoryCD.name = name
            
            do {
                try categoryCD.save()
                
                completion()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func getCategoryCD() -> CategoryCD {
        if isEdit, let categoryCD = categoryVM?.categoryCD {
            return categoryCD
        } else {
            return CategoryCD.init(context: CategoryCD.viewContext)
        }
    }
}
