//
//  CategoryScreen.swift
//  PriceLog
//
//  Created by William Santoso on 26/06/22.
//

import SwiftUI

struct CategoryScreen: View {
    @StateObject private var viewModel = CategoryScreenViewModel()
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
                    ForEach(viewModel.categoriesVM.indices, id: \.self) { index in
                        let categoryVM = viewModel.categoriesVM[index]
                        
                        NavigationLink {
                            ProductScreen(viewModel: ProductScreenViewModel(categoryVM: categoryVM))
                        } label: {
                            CategoryCellView(
                                title: categoryVM.category.name,
                                onEdit: {
                                    viewModel.selectedCategoryIndex = index
                                    isShowAddCategory.toggle()
                                }, onDelete: {
                                    viewModel.selectedCategoryIndex = index
                                    viewModel.deleteCategory(by: viewModel.categories[index].id)
                                }
                            )
                        }
                    }
                }
                .padding(.horizontal, 12)
            }
            .onAppear {
                viewModel.getCategoriesCD()
            }
            .refreshable {
                viewModel.getCategoriesCD()
            }
            .searchable(text: $viewModel.searchText, placement: .automatic, prompt: viewModel.randomSearchPrompt)
            .navigationTitle("Category")
            .sheet(isPresented: $isShowAddCategory, onDismiss: {
                viewModel.selectedCategoryIndex = nil
                viewModel.getCategoriesCD()
            }) {
                AddCategoryScreen(
                    viewModel: AddCategoryViewModel(categoryVM: viewModel.selectedCategoryVM),
                    onSave: {
                    },
                    onDelete: {
                        if let id = viewModel.selectedCategoryVM?.id {
                            viewModel.deleteCategory(by: id)
                        }
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
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        viewModel.deleteAll()
                    } label: {
                        Text("Delete All")
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

