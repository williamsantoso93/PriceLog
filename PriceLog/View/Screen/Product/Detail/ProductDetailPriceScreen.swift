//
//  ProductDetailPriceScreen.swift
//  PriceLog
//
//  Created by William Santoso on 26/06/22.
//

import SwiftUI

struct ProductDetailPriceScreen: View {
    @StateObject private var viewModel: ProductDetailPriceViewModel
    @State private var isShowAddProductDetail: Bool = false
    
    init(viewModel: ProductDetailPriceViewModel) {
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
                        ProductPricesCell(price: lowestPrice)
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
                    
                    ForEach(viewModel.prices.indices, id: \.self) { index in
                        let price = viewModel.prices[index]
                        
                        Button {
                            viewModel.selectedPriceIndex = index
                            isShowAddProductDetail.toggle()
                        } label: {
                            ProductPricesCell(price: price)
                                .contextMenu {
                                    Button(role: .destructive) {
                                        viewModel.selectedPriceIndex = index
                                        viewModel.deletePrice()
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
        .sheet(isPresented: $isShowAddProductDetail, onDismiss: {
            viewModel.selectedPriceIndex = nil
        }) {
            AddProductDetailScreen(
                viewModel: AddProductDetailPriceViewModel(price: viewModel.selectedPrice),
                onSave: { price in
                    if let price = price {
                        viewModel.setSavedPrice(price: price)
                    }
                },
                onDelete: {
                    viewModel.deletePrice()
                }
            )
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProductDetailPriceScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProductDetailPriceScreen(viewModel: ProductDetailPriceViewModel(product: productsMock[0], selectedTypeIndex: 0))
        }
    }
}
