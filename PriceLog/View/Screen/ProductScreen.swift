//
//  ProductScreen.swift
//  PriceLog
//
//  Created by William Santoso on 26/06/22.
//

import SwiftUI

class ProductViewModel: ObservableObject {
    @Published var products: [Product] = productsMock
}

struct ProductScreen: View {
    @StateObject private var viewModel = ProductViewModel()
    
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
    }
}

struct ProductScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProductScreen()
        }
    }
}
