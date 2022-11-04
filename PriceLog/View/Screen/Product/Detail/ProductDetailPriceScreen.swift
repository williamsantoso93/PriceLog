//
//  ProductDetailPriceScreen.swift
//  PriceLog
//
//  Created by William Santoso on 26/06/22.
//

import SwiftUI

struct ProductDetailPriceScreen: View {
    @StateObject private var viewModel: ProductDetailScreenPriceViewModel
    @State private var isShowAddProductDetail: Bool = false
    
    init(viewModel: ProductDetailScreenPriceViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            Rectangle()
                .frame(height: 300)
            
            VStack(alignment: .leading, spacing: 20.0) {
                VStack(alignment: .leading) {
                    Text(viewModel.title)
                    
                    HStack {
                        Image(systemName: "scalemass")
                        
                        Text("\(viewModel.unit.splitDigit(maximumFractionDigits: 2)) \(viewModel.unitName)")
                    }
                }
                
                if let lowestPrice = viewModel.lowestPrice {
                    VStack {
                        HStack {
                            Text("Lowest Price")
                            
                            Spacer()
                        }
                        ProductPricesCell(productPrice: lowestPrice)
                    }
                }
                
                VStack {
                    HStack {
                        Text("Price")
                        
                        Spacer()
                        
                        Button {
                            isShowAddProductDetail.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                    
                    ForEach(viewModel.productPricesVM.indices, id: \.self) { index in
                        let productPriceVM = viewModel.productPricesVM[index]
                        
                        Button {
                            viewModel.selectedPriceIndex = index
                            isShowAddProductDetail.toggle()
                        } label: {
                            ProductPricesCell(productPrice: productPriceVM.productPrice)
                                .contextMenu {
                                    Button(role: .destructive) {
                                        viewModel.selectedPriceIndex = index
                                        viewModel.deleteProductPrice(by: productPriceVM.id)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }
                    }
                }
            }
            .padding(.horizontal, 12)
        }
        .onAppear {
            viewModel.getProductPricesCD()
        }
        .refreshable {
            viewModel.getProductPricesCD()
        }
        .sheet(isPresented: $isShowAddProductDetail, onDismiss: {
            viewModel.selectedPriceIndex = nil
            viewModel.getProductPricesCD()
        }) {
            AddProductDetailScreen(
                viewModel: AddProductDetailPriceViewModel(productTypeId: viewModel.productTypeId, productPriceVM: viewModel.selectedPriceVM),
                onSave: { },
                onDelete: {
                    if let id = viewModel.selectedPriceVM?.id {
                        viewModel.deleteProductPrice(by: id)
                    }
                }
            )
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProductDetailPriceScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProductDetailPriceScreen(viewModel: ProductDetailScreenPriceViewModel(productTypeVM: ProductTypeViewModel(productTypeCD: ProductTypeCD.init(context: ProductTypeCD.viewContext))))
        }
    }
}
