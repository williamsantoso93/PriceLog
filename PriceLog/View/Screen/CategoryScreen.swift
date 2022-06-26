//
//  CategoryScreen.swift
//  PriceLog
//
//  Created by William Santoso on 26/06/22.
//

import SwiftUI

class CategoryViewModel: ObservableObject {
    @Published var categories: [Category] = categoriesMock
}

struct CategoryScreen: View {
    @StateObject private var viewModel = CategoryViewModel()
    
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
                            ProductTypeScreen()
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
    }
}
