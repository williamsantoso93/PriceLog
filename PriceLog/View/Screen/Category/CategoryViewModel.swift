//
//  CategoryViewModel.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import Foundation

class CategoryViewModel: ObservableObject {
    @Published var categories: [Category] = categoriesMock
    
    var selectedCategoryIndex: Int?
    var selectedCategory: Category? {
        guard let selectedCategoryIndex = selectedCategoryIndex, categories.indices.contains(selectedCategoryIndex) else {
            return nil
        }
        return categories[selectedCategoryIndex]
    }
    
    func setSavedCategory(category: Category) {
        if let selectedCategoryIndex = selectedCategoryIndex, categories.indices.contains(selectedCategoryIndex) {
            categories[selectedCategoryIndex] = category
        } else {
            categories.append(category)
        }
    }
    
    func deleteCategory() {
        guard let selectedCategoryIndex = selectedCategoryIndex, categories.indices.contains(selectedCategoryIndex) else {
            return
        }
        
        categories.remove(at: selectedCategoryIndex)
    }
}
