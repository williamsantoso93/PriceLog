//
//  CategoryViewModel.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import Foundation

class CategoryViewModel: ObservableObject {
    private var _categories: [Category] = categoriesMock
    var categories: [Category] {
        _categories.filter { category in
            searchText.isEmpty ? true : category.name.contains(searchText)
        }
    }
    var selectedCategoryIndex: Int?
    var selectedCategory: Category? {
        guard let selectedCategoryIndex = selectedCategoryIndex, _categories.indices.contains(selectedCategoryIndex) else {
            return nil
        }
        return _categories[selectedCategoryIndex]
    }
    var randomSearchPrompt: String {
        _categories[Int.random(in: _categories.indices)].name
    }
    
    @Published var searchText: String = ""
    
    func setSavedCategory(category: Category) {
        if let selectedCategoryIndex = selectedCategoryIndex, _categories.indices.contains(selectedCategoryIndex) {
            _categories[selectedCategoryIndex] = category
        } else {
            _categories.append(category)
        }
    }
    
    func deleteCategory() {
        guard let selectedCategoryIndex = selectedCategoryIndex, _categories.indices.contains(selectedCategoryIndex) else {
            return
        }
        
        _categories.remove(at: selectedCategoryIndex)
    }
}
