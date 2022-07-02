//
//  ProductTypeScreen.swift
//  PriceLog
//
//  Created by William Santoso on 26/06/22.
//

import SwiftUI

struct ProductTypeScreen: View {
    @StateObject private var viewModel = ProductTypeViewModel()
    @State private var isShowAddProductType: Bool = false
    
    var body: some View {
        ZStack {
            Rectangle() //TODO: replace with product image
                .foregroundColor(.clear)
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    ForEach(viewModel.productTypes) { productType in
                        NavigationLink {
                            ProductDetailPriceScreen()
                        } label: {
                            ProductTypeCellView(type: productType)
                        }
                    }
                }
                .padding(.horizontal, 12)
            }
        }
        .searchable(text: .constant(""), placement: .automatic, prompt: "Cereal")
        .navigationTitle("Coco Crunch")
        .sheet(isPresented: $isShowAddProductType) {
            AddProductTypeScreen()
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
            ProductTypeScreen()
        }
    }
}
