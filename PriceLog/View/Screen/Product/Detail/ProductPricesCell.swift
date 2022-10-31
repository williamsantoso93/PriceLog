//
//  ProductPricesCell.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import SwiftUI

struct ProductPricesCell: View {
    var productPrice: ProductPrice
    
    var body: some View {
        HStack {
            Text("Rp \(productPrice.value.splitDigit())")
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(productPrice.store.name)
                
                Text("\(productPrice.date.toString())")
            }
        }
        .padding()
        .background {
            Color.gray.opacity(0.2)
                .cornerRadius(10)
        }
    }
}

struct ProductPricesCell_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ProductPricesCell(productPrice: pricesMock[0][0])
        }
        .padding()
    }
}
