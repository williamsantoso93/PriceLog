//
//  AddProductTypeScreen.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import SwiftUI

struct AddProductTypeScreen: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                TextFieldLabel(label: "Name", text: .constant(""))
                TextFieldLabel(label: "Weight", text: .constant(""), unit: "g") //TODO: get unit from model
            }
            .navigationTitle("Add Product Type")
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

struct AddProductTypeScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddProductTypeScreen()
    }
}
