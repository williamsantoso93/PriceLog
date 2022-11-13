//
//  ProductScreen.swift
//  PriceLog
//
//  Created by William Santoso on 26/06/22.
//

import SwiftUI

struct ProductScreen: View {
    @StateObject private var viewModel: ProductScreenViewModel
    @State private var isShowAddProduct: Bool = false
    
    private let gridColumns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(viewModel: ProductScreenViewModel = ProductScreenViewModel()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    private func getProductName(product: String, brand: String?) -> String {
        var productName = product
        if let brandName = brand {
            productName = "\(brandName) - \(productName)"
        }
        
        return productName
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
                                title: getProductName(product: productVM.product.name, brand: productVM.product.brand?.name),
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
            .navigationTitle(viewModel.titleName)
            .sheet(isPresented: $isShowAddProduct, onDismiss: {
                viewModel.selectedProductIndex = nil
                viewModel.getProductsCD()
            }) {
                if viewModel.isFullProduct {
                    AddFullProductScreen()
                } else {
                    AddProductScreen(
                        viewModel: AddProductViewModel(categoryId: viewModel.categoryId, brandId: viewModel.brandId, productVM: viewModel.selectedProductVM),
                        onSave: { },
                        onDelete: {
                            if let id = viewModel.selectedProductVM?.id {
                                viewModel.deleteProduct(by: id)
                            }
                        }
                    )
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .automatic) {
                    Button {
                        isShowAddProduct.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
    //                ToolbarItem(placement: .navigationBarLeading) {
    //                    Button {
    //                        viewModel.deleteAll()
    //                    } label: {
    //                        Text("Delete All")
    //                    }
    //                }
            }
        }
    }
}

struct ProductScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProductScreen(viewModel: ProductScreenViewModel(categoryVM: CategoryViewModel(categoryCD: CategoryCD.init(context: CategoryCD.viewContext))))
        }
    }
}
