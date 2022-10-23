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
                            ProductScreen()
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
            .searchable(text: .constant(""), placement: .automatic, prompt: "Cereal")
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

struct CategoryCellView: View {
    let title: String
    let onEdit: (() -> Void)?
    let onDelete: (() -> Void)?
    
    init(title: String, onEdit: (() -> Void)? = nil, onDelete: (() -> Void)? = nil) {
        self.title = title
        self.onEdit = onEdit
        self.onDelete = onDelete
    }
    
    var body: some View {
        ZStack {
            Color.gray
                .frame(height: 100)
            Text(title)
        }
        .cornerRadius(10)
        .contextMenu {
            if let onEdit = onEdit {
                Button {
                    onEdit()
                } label: {
                    Label("Edit", systemImage: "pencil")
                }
            }
            
            if let onDelete = onDelete {
                Button(role: .destructive) {
                    onDelete()
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
        }
    }
}
