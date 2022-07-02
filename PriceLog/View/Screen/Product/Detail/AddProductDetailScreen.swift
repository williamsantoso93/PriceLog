//
//  AddProductDetailScreen.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import SwiftUI

struct AddProductDetailScreen: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                NumberFieldLabel(label: "Value", text: .constant(""))
                TextFieldLabel(label: "Place", text: .constant(""))
                DatePicker("Date", selection: .constant(Date()), displayedComponents: .date)
            }
            .navigationTitle("Add Product Detail")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .automatic) {
                    Button {
                        
                    } label: {
                        Text("Save")
                    }
                }
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
            }
        }
    }
}

struct AddProductDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddProductDetailScreen()
    }
}
