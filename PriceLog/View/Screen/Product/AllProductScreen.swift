//
//  AllProductScreen.swift
//  PriceLog
//
//  Created by William Santoso on 04/11/22.
//

import SwiftUI

struct AllProductScreen: View {
    @StateObject private var viewModel: AllProductScreenViewModel
    @State private var isShowAddProduct: Bool = false
    
    private let gridColumns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(viewModel: AllProductScreenViewModel = AllProductScreenViewModel()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
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
            .navigationTitle("Product")
            .sheet(isPresented: $isShowAddProduct, onDismiss: {
                viewModel.selectedProductIndex = nil
                viewModel.getProductsCD()
            }) {
                AddProductScreen(
                    viewModel: AddProductViewModel(categoryId: viewModel.categoryId, productVM: viewModel.selectedProductVM),
                    onSave: { },
                    onDelete: {
                        if let id = viewModel.selectedProductVM?.id {
                            viewModel.deleteProduct(by: id)
                        }
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

struct AllProductScreen_Previews: PreviewProvider {
    static var previews: some View {
        AllProductScreen(viewModel: AllProductScreenViewModel())
    }
}
