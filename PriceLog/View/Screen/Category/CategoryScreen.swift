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
                    ForEach(viewModel.categories) { category in
                        NavigationLink {
                            ProductScreen()
                        } label: {
                            CategoryCellView(title: category.name)
                        }
                    }
                }
                .padding(.horizontal, 12)
                
                Spacer(minLength: 0)
            }
            .searchable(text: .constant(""), placement: .automatic, prompt: "Cereal")
            .navigationTitle("Category")
            .sheet(isPresented: $isShowAddCategory) {
                AddCategoryScreen()
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
    
    var body: some View {
        ZStack {
            Color.gray
                .frame(height: 100)
            Text(title)
        }
        .cornerRadius(10)
//        .contextMenu {
//            Button {
//                print("Change country setting")
//            } label: {
//                Label("Edit", systemImage: "pencil")
//            }
//            
//            Button(role: .destructive) {
//                print("Enable geolocation")
//            } label: {
//                Label("Delete", systemImage: "trash")
//            }
//        }
    }
}
