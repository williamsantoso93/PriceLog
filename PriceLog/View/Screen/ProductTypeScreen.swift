//
//  ProductTypeScreen.swift
//  PriceLog
//
//  Created by William Santoso on 26/06/22.
//

import SwiftUI

class ProductTypeViewModel: ObservableObject {
    @Published var productTypes: [ProductType] = productTypesMock
}

struct ProductTypeScreen: View {
    @StateObject private var viewModel = ProductTypeViewModel()
    
    var body: some View {
        ZStack {
            Rectangle() //TODO: replace with product image
                .foregroundColor(.clear)
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    ForEach(viewModel.productTypes) { productType in
                        NavigationLink {
                            ProductTypeScreen()
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
    }
}

struct ProductDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProductTypeScreen()
        }
    }
}

struct ProductTypeCellView: View {
    var type: ProductType
    var body: some View {
        HStack {
            Rectangle() //TODO: replace with product image
                .cornerRadius(10)
                .frame(width: 75, height: 75)
            
            //TODO: replace sama grid
            HStack {
                VStack(alignment: .leading) {
                    Text(type.name)
                    
                    HStack(alignment: .center) {
                        Image(systemName: "scalemass")
                        
                        Text("\(type.unit) \(type.unitType.rawValue)")
                    }
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Rp \(type.lowestPrice?.value ?? 0)")
                    
                    HStack(alignment: .center) {
                        Image(systemName: "house")
                        
                        Text("\(type.lowestPrice?.place.name ?? "")")
                    }
                }
            }
            .padding()
            .background {
                Color.gray.opacity(0.5)
                    .cornerRadius(10)
            }
        }
    }
}
