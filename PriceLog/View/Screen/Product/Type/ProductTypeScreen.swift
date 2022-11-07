//
//  ProductTypeScreen.swift
//  PriceLog
//
//  Created by William Santoso on 26/06/22.
//

import SwiftUI

struct ProductTypeScreen: View {
    @StateObject private var viewModel: ProductTypeScreenViewModel
    @State private var isShowAddProductType: Bool = false
    
    init(viewModel: ProductTypeScreenViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Rectangle() //TODO: replace with product image
                .foregroundColor(.clear)
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    ForEach(viewModel.productTypesVM.indices, id:\.self) { index in
                        let productTypeVM = viewModel.productTypesVM[index]
                        
                        NavigationLink {
                            ProductDetailPriceScreen(viewModel: ProductDetailScreenPriceViewModel(productTypeVM: productTypeVM))
                        } label: {
                            ProductTypeCellView(
                                type: productTypeVM.productType,
                                onEdit: {
                                    viewModel.selectedTypeIndex = index
                                    isShowAddProductType.toggle()
                                }, onDelete: {
                                    viewModel.selectedTypeIndex = index
                                    viewModel.deleteProductType(by: productTypeVM.id)
                                }
                            )
                        }
                    }
                }
                .padding(.horizontal, 12)
            }
        }
        .onAppear {
            viewModel.getProductTypesCD()
        }
        .refreshable {
            viewModel.getProductTypesCD()
        }
        .searchable(text: $viewModel.searchText, placement: .automatic, prompt: viewModel.randomSearchPrompt)
        .navigationTitle(viewModel.productName)
        .sheet(isPresented: $isShowAddProductType, onDismiss: {
            viewModel.selectedTypeIndex = nil
            viewModel.getProductTypesCD()
        }) {
            AddProductTypeScreen(
                viewModel: AddProductTypeViewModel(productId: viewModel.productId, productTypeVM: viewModel.selectedTypeVM),
                onSave: { },
                onDelete: {
                    if let id = viewModel.selectedTypeVM?.id {
                        viewModel.deleteProductType(by: id)
                    }
                }
            )
        }
        .toolbar {
            ToolbarItemGroup(placement: .automatic) {
                Button {
                    isShowAddProductType.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button {
//                    viewModel.deleteAll()
//                } label: {
//                    Text("Delete All")
//                }
//            }
        }
    }
}

struct ProductDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProductTypeScreen(viewModel: ProductTypeScreenViewModel(productVM: ProductViewModel(productCD: ProductCD.init(context: ProductCD.viewContext))))
        }
    }
}
