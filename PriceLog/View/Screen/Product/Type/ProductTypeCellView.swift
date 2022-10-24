//
//  ProductTypeCellView.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import SwiftUI

struct ProductTypeCellView: View {
    var type: ProductType
    let onEdit: (() -> Void)?
    let onDelete: (() -> Void)?
    
    init(type: ProductType, onEdit: (() -> Void)? = nil, onDelete: (() -> Void)? = nil) {
        self.type = type
        self.onEdit = onEdit
        self.onDelete = onDelete
    }
    
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
                        
                        Text("\(type.unit.splitDigit(maximumFractionDigits: 2)) \(type.unitType.getTitle(by: type.unit))")
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
        .contextMenu {
            if let onEdit = onEdit {
                Button {
                    onEdit()
                } label: {
                    Label("Edit", systemImage: "pencil")
                }
            }
            
            if let onDelete = onDelete {
                Button(role: .destructive) {
                    onDelete()
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
        }
    }
}

struct ProductTypeCellView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ProductTypeCellView(type: productTypesMock[1])
        }
        .padding()
    }
}
