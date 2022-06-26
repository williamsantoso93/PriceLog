//
//  ProductPriceScreen.swift
//  PriceLog
//
//  Created by William Santoso on 26/06/22.
//

import SwiftUI

class ProductPriceViewModel: ObservableObject {
    @Published var prices: [Price] = pricesMock
}

struct ProductPriceScreen: View {
    @StateObject private var viewModel = ProductPriceViewModel()
    
    var body: some View {
        ScrollView {
            Rectangle()
                .frame(height: 300)
            
            VStack(alignment: .leading, spacing: 40.0) {
                VStack(alignment: .leading) {
                    Text("Coco crunch - Besar")
                    
                    HStack(alignment: .center) {
                        Image(systemName: "scalemass")
                        
                        Text("400 g")
                    }
                }
                
                VStack {
                    HStack {
                        Text("Price")
                        
                        Spacer()
                    }
                    
                    ForEach(viewModel.prices) { price in
                        ProductPricesCell(price: price)
                    }
                }
            }
            .padding(.horizontal, 12)
        }
    }
}

struct ProductPriceScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProductPriceScreen()
    }
}

struct ProductPricesCell: View {
    var price: Price
    
    var body: some View {
        HStack {
            Text("Rp \(price.value)")
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text(price.place.name)
                
                Text("\(price.updatedDate.formatted())")
            }
        }
        .padding()
        .background {
            Color.gray.opacity(0.5)
                .cornerRadius(10)
        }
    }
}
