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
    
    //TODO: update when edit
    
    func save(completion: (Category?) -> Void) {
        if !name.isEmpty {
            category?.name = name
            
            let categoryCD = CategoryCD(context: CategoryCD.viewContext)
            categoryCD.id = UUID()
            categoryCD.name = name
            
            do {
                try categoryCD.save()
                
                completion(category)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
