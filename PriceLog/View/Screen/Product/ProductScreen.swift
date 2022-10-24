//
//  ProductScreen.swift
//  PriceLog
//
//  Created by William Santoso on 26/06/22.
//

import SwiftUI

struct ProductScreen: View {
    @StateObject private var viewModel: ProductViewModel
    @State private var isShowAddProduct: Bool = false
    
    private let gridColumns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(viewModel: ProductViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridColumns, alignment: .leading) {
                ForEach(viewModel.products.indices, id: \.self) { index in
                    let product = viewModel.products[index]
                    
                    NavigationLink {
                        ProductTypeScreen()
                    } label: {
                        CategoryCellView(
                            title: product.name,
                            onEdit: {
                                viewModel.selectedProductIndex = index
                                isShowAddProduct.toggle()
                            }, onDelete: {
                                viewModel.selectedProductIndex = index
                                viewModel.deleteProduct()
                            }
                        )
                    }
                }
            }
            .padding(.horizontal, 12)
            
            Spacer(minLength: 0)
        }
        .searchable(text: $viewModel.searchText, placement: .automatic, prompt: viewModel.randomSearchPrompt)
        .navigationTitle(viewModel.categoryName)
        .sheet(isPresented: $isShowAddProduct, onDismiss: {
            viewModel.selectedProductIndex = nil
        }) {
            AddProductScreen(
                viewModel: AddProductViewModel(product: viewModel.selectedProduct),
                onSave: { product in
                    if let product = product {
                        viewModel.setSavedProduct(product: product)
                    }
                },
                onDelete: {
                    viewModel.deleteProduct()
                }
            )
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
            ProductScreen(viewModel: ProductViewModel(category: categoriesMock[0]))
        }
    }
}
