//
//  ProductDetailPriceScreen.swift
//  PriceLog
//
//  Created by William Santoso on 26/06/22.
//

import SwiftUI

struct ProductDetailPriceScreen: View {
    @StateObject private var viewModel = ProductDetailPriceViewModel()
    @State private var isShowAddProductDetail: Bool = false
    
    var body: some View {
        ScrollView {
            Rectangle()
                .frame(height: 300)
            
            VStack(alignment: .leading, spacing: 40.0) {
                VStack(alignment: .leading) {
                    Text("Coco crunch - Besar")
                    
                    HStack {
                        Image(systemName: "scalemass")
                        
                        Text("400 g")
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
                    
                    ForEach(viewModel.prices) { price in
                        Button {
                            isShowAddProductDetail.toggle()
                        } label: {
                            ProductPricesCell(price: price)
                                .contextMenu {
                                    Button {
                                        print("Change country setting")
                                    } label: {
                                        Label("Edit", systemImage: "pencil")
                                    }
                                    
                                    Button(role: .destructive) {
                                        print("Enable geolocation")
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
        .sheet(isPresented: $isShowAddProductDetail) {
            AddProductDetailScreen()
        }
    }
}

struct ProductDetailPriceScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailPriceScreen()
    }
}
