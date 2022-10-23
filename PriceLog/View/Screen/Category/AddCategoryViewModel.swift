//
//  AddCategoryViewModel.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import Foundation

class AddCategoryViewModel: ObservableObject {
    @Published var title: String = ""
    var category: Category?
    
    var isEdit: Bool = false
    
    init(category: Category? = nil) {
        if let category = category {
            self.category = category
            self.title = category.name
            isEdit = true
        } else {
            self.category = Category()
        }
    }
    
    func save(completion: (Category?) -> Void) {
        if !title.isEmpty {
            category?.name = title
            
            //TODO: save action
            completion(category)
        }
    }
}
