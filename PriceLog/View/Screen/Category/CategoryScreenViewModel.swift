//
//  CategoryScreenViewModel.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import Foundation
import CoreData

class CategoryScreenViewModel: ObservableObject {
    @Published private var _categories: [Category] = categoriesMock
    @Published private var _categoriesCD: [CategoryViewModel] = []
    
    @Published var searchText: String = ""
    
    var categories: [(id: NSManagedObjectID, category: Category)] {
        _categoriesCD.filter { categoryViewModel in
            searchText.isEmpty ? true : categoryViewModel.category.name.lowercased().contains(searchText.lowercased())
        }.map { categoryViewModel in
            (categoryViewModel.categoryID, categoryViewModel.category)
        }
    }
    var categoriesCD: [CategoryViewModel] {
        _categoriesCD.filter { categoryViewModel in
            searchText.isEmpty ? true : categoryViewModel.category.name.lowercased().contains(searchText.lowercased())
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
    
    func setSavedCategory(category: Category) {
//        if let selectedCategoryIndex = selectedCategoryIndex, _categories.indices.contains(selectedCategoryIndex) {
//            _categories[selectedCategoryIndex] = category
//        } else {
//            _categories.append(category)
//        }
    }
    
    func deleteCategory() {
        guard let selectedCategoryIndex = selectedCategoryIndex, _categories.indices.contains(selectedCategoryIndex) else {
            return
        }
        
        _categories.remove(at: selectedCategoryIndex)
    }
    
    func getCategoriesCD() {
        DispatchQueue.main.async {
            self._categoriesCD = CategoryCD.all().map(CategoryViewModel.init)
        }
    }
    
    func deleteCategory(by id: NSManagedObjectID) {
        let category: CategoryCD? = CategoryCD.byId(id: id)
        if let category = category {
            do {
                try category.delete()
                getCategoriesCD()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteAll() {
        for category in categoriesCD {
            do {
                try category.delete()
            } catch {
                print(error.localizedDescription)
            }
        }
        getCategoriesCD()
    }
}

struct CategoryViewModel {
    private let categoryCD: CategoryCD
    
    init(categoryCD: CategoryCD) {
        self.categoryCD = categoryCD
    }
    
    var categoryID: NSManagedObjectID {
        categoryCD.objectID
    }
    
    var category: Category {
        Category(
            id: categoryCD.id ?? UUID(),
            name: categoryCD.name ?? "",
            image: nil,
            products: []
        )
    }
    
    func delete() throws {
        try categoryCD.delete()
    }
}
