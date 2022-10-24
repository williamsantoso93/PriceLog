//
//  ProductTypeScreen.swift
//  PriceLog
//
//  Created by William Santoso on 26/06/22.
//

import SwiftUI

struct ProductTypeScreen: View {
    @StateObject private var viewModel: ProductTypeViewModel
    @State private var isShowAddProductType: Bool = false
    
    init(viewModel: ProductTypeViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Rectangle() //TODO: replace with product image
                .foregroundColor(.clear)
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    ForEach(viewModel.types.indices, id:\.self) { index in
                        let type = viewModel.types[index]
                        
                        NavigationLink {
                            ProductDetailPriceScreen(viewModel: ProductDetailPriceViewModel(product: viewModel.product, selectedTypeIndex: index))
                        } label: {
                            ProductTypeCellView(
                                type: type,
                                onEdit: {
                                    viewModel.selectedTypeIndex = index
                                    isShowAddProductType.toggle()
                                }, onDelete: {
                                    viewModel.selectedTypeIndex = index
                                    viewModel.deleteType()
                                }
                            )
                        }
                    }
                }
                .padding(.horizontal, 12)
            }
        }
        .searchable(text: $viewModel.searchText, placement: .automatic, prompt: viewModel.randomSearchPrompt)
        .navigationTitle(viewModel.productName)
        .sheet(isPresented: $isShowAddProductType, onDismiss: {
            viewModel.selectedTypeIndex = nil
        }) {
            AddProductTypeScreen(
                viewModel: AddProductTypeViewModel(type: viewModel.selectedType),
                onSave: { type in
                    if let type = type {
                        viewModel.setSavedType(type: type)
                    }
                },
                onDelete: {
                    viewModel.deleteType()
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
        }
    }
}

struct ProductDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProductTypeScreen(viewModel: ProductTypeViewModel(product: categoriesMock[0].products[0]))
        }
    }
}
