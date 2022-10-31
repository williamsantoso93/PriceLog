//
//  CategoryScreenViewModel.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import Foundation
import CoreData

class CategoryScreenViewModel: ObservableObject {
    @Published private var _categoriesVM: [CategoryViewModel] = []
    private var _categories: [Category] {
        _categoriesVM.map { categoryViewModel in
            categoryViewModel.category
        }
    }
    
    @Published var searchText: String = ""
    
    var categoriesVM: [CategoryViewModel] {
        _categoriesVM.filter { categoryViewModel in
            searchText.isEmpty ? true : categoryViewModel.category.name.lowercased().contains(searchText.lowercased())
        }
    }
    var categories: [(id: NSManagedObjectID, category: Category)] {
        categoriesVM.map { categoryViewModel in
            (categoryViewModel.id, categoryViewModel.category)
        }
    }
    
    var selectedCategoryIndex: Int?
    var selectedCategory: Category? {
        guard let selectedCategoryIndex = selectedCategoryIndex, _categories.indices.contains(selectedCategoryIndex) else {
            return nil
        }
        return _categories[selectedCategoryIndex]
    }
    var selectedCategoryVM: CategoryViewModel? {
        guard let selectedCategoryVMIndex = selectedCategoryIndex, categoriesVM.indices.contains(selectedCategoryVMIndex) else {
            return nil
        }
        return categoriesVM[selectedCategoryVMIndex]
    }
    var randomSearchPrompt: String {
        _categories.isEmpty ? "" : _categories[Int.random(in: _categories.indices)].name
    }
    
    func setSavedCategory(category: Category) {
//        if let selectedCategoryIndex = selectedCategoryIndex, _categories.indices.contains(selectedCategoryIndex) {
//            _categories[selectedCategoryIndex] = category
//        } else {
//            _categories.append(category)
//        }
    }
    
    func deleteCategory() {
//        guard let selectedCategoryIndex = selectedCategoryIndex, _categories.indices.contains(selectedCategoryIndex) else {
//            return
//        }
//
//        _categories.remove(at: selectedCategoryIndex)
    }
    
    func getCategoriesCD() {
        DispatchQueue.main.async {
            self._categoriesVM = CategoryCD.all().map(CategoryViewModel.init)
        }
    }
    
    func deleteCategory(by id: NSManagedObjectID) {
        if let category: CategoryCD = CategoryCD.byId(id: id) {
            do {
                try category.delete()
                getCategoriesCD()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteAll() {
        for category in _categoriesVM {
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
    
    var id: NSManagedObjectID {
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
    
    func getProductsVM() -> [ProductViewModel] {
        ProductCD.getProducts(by: id).map(ProductViewModel.init)
    }
}
