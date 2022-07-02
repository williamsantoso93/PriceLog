//
//  ProductScreen.swift
//  PriceLog
//
//  Created by William Santoso on 26/06/22.
//

import SwiftUI

struct ProductScreen: View {
    @StateObject private var viewModel = ProductViewModel()
    @State private var isShowAddProduct: Bool = false
    
    private let gridColumns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridColumns, alignment: .leading) {
                ForEach(viewModel.products) { product in
                    NavigationLink {
                        ProductTypeScreen()
                    } label: {
                        CategoryCellView(title: product.name)
                    }
                }
            }
            .padding(.horizontal, 12)
            
            Spacer(minLength: 0)
        }
        .searchable(text: .constant(""), placement: .automatic, prompt: "Cereal")
        .navigationTitle("Cereal")
        .sheet(isPresented: $isShowAddProduct) {
            AddProductScreen()
        }
        .toolbar {
            ToolbarItemGroup(placement: .automatic) {
                Button {
                    isShowAddProduct.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct ProductScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProductScreen()
        }
    }
}
