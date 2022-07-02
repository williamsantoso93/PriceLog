//
//  ProductPricesCell.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import SwiftUI

struct ProductPricesCell: View {
    var price: Price
    
    var body: some View {
        HStack {
            Text("Rp \(price.value.splitDigit())")
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(price.place.name)
                
                Text("\(price.updatedDate.toString())")
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
            ProductPricesCell(price: pricesMock[0])
        }
        .padding()
    }
}
