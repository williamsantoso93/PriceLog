//
//  CategoryScreen.swift
//  PriceLog
//
//  Created by William Santoso on 26/06/22.
//

import SwiftUI

struct CategoryScreen: View {
    @StateObject private var viewModel = CategoryViewModel()
    @State private var isShowAddCategory: Bool = false
    
    private let gridColumns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: gridColumns, alignment: .leading) {
                    ForEach(viewModel.categories.indices, id: \.self) { index in
                        let category = viewModel.categories[index]
                        
                        NavigationLink {
                            ProductScreen(viewModel: ProductViewModel(category: category))
                        } label: {
                            CategoryCellView(
                                title: category.name,
                                onEdit: {
                                    viewModel.selectedCategoryIndex = index
                                    isShowAddCategory.toggle()
                                }, onDelete: {
                                    viewModel.selectedCategoryIndex = index
                                    viewModel.deleteCategory()
                                }
                            )
                        }
                    }
                }
                .padding(.horizontal, 12)
                
                Spacer(minLength: 0)
            }
            .searchable(text: $viewModel.searchText, placement: .automatic, prompt: viewModel.randomSearchPrompt)
            .navigationTitle("Category")
            .sheet(isPresented: $isShowAddCategory, onDismiss: {
                viewModel.selectedCategoryIndex = nil
            }) {
                AddCategoryScreen(
                    viewModel: AddCategoryViewModel(category: viewModel.selectedCategory),
                    onSave: { category in
                        if let category = category {
                            viewModel.setSavedCategory(category: category)
                        }
                    },
                    onDelete: {
                        viewModel.deleteCategory()
                    }
                )
            }
            .toolbar {
                ToolbarItemGroup(placement: .automatic) {
                    Button {
                        isShowAddCategory.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

struct CategoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        CategoryScreen()
    }
}

