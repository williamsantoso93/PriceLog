//
//  ProductTypeCellView.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import SwiftUI

struct ProductTypeCellView: View {
    var type: ProductType
    
    var body: some View {
        HStack {
            Color.gray.opacity(0.1)
                .cornerRadius(10)
                .frame(width: 75, height: 75)
                .overlay {
                    Image(systemName: "bag") //TODO: replace with product image
                        .font(.system(size: 38))
                        .cornerRadius(10)
                }
            
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
                
                if let lowestPrice = type.lowestPrice {
                    VStack(alignment: .trailing) {
                        Text("Rp \(lowestPrice.value.splitDigit())")
                        
                        HStack(alignment: .center) {
                            Image(systemName: "house")
                            
                            Text("\(lowestPrice.place.name)")
                        }
                    }
                }
            }
            .padding()
            .background {
                Color.gray.opacity(0.1)
                    .cornerRadius(10)
            }
        }
    }
}

struct ProductTypeCellView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ProductTypeCellView(type: productTypesMock[0])
        }
        .padding()
    }
}
