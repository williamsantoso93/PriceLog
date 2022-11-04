//
//  ProductStoreScreen.swift
//  PriceLog
//
//  Created by William Santoso on 04/11/22.
//

import SwiftUI

struct ProductStoreScreen: View {
    @StateObject private var viewModel: ProductStoreScreenViewModel
    @State private var isShowAddProduct: Bool = false
    
    private let gridColumns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(viewModel: ProductStoreScreenViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridColumns, alignment: .leading) {
                ForEach(viewModel.productsVM.indices, id: \.self) { index in
                    let productVM = viewModel.productsVM[index]
                    
                    NavigationLink {
                        ProductTypeScreen(viewModel: ProductTypeScreenViewModel(productVM: productVM))
                    } label: {
                        CategoryCellView(
                            title: productVM.product.name,
                            onEdit: {
                                viewModel.selectedProductIndex = index
                                isShowAddProduct.toggle()
                            }, onDelete: {
                                viewModel.selectedProductIndex = index
                                viewModel.deleteProduct(by: productVM.id)
                            }
                        )
                    }
                }
            }
            .padding(.horizontal, 12)
            
            Spacer(minLength: 0)
        }
        .onAppear {
            viewModel.getProductsCD()
        }
        .refreshable {
            viewModel.getProductsCD()
        }
        .searchable(text: $viewModel.searchText, placement: .automatic, prompt: viewModel.randomSearchPrompt)
        .navigationTitle(viewModel.storeName)
        .sheet(isPresented: $isShowAddProduct, onDismiss: {
            viewModel.selectedProductIndex = nil
            viewModel.getProductsCD()
        }) {
            AddProductScreen(
                viewModel: AddProductViewModel(productVM: viewModel.selectedProductVM),
                onSave: { },
                onDelete: {
                    if let id = viewModel.selectedProductVM?.id {
                        viewModel.deleteProduct(by: id)
                    }
                }
            )
        }
        .toolbar {
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

struct ProductStoreScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProductStoreScreen(viewModel: ProductStoreScreenViewModel(storeVM: StoreViewModel(storeCD: StoreCD.init(context: StoreCD.viewContext))))
    }
}
