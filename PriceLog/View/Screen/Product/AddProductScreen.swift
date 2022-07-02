//
//  AddProductScreen.swift
//  PriceLog
//
//  Created by William Santoso on 27/06/22.
//

import SwiftUI

struct AddProductScreen: View {
    @Environment(\.dismiss) private var dismiss
    @State private var categorySelection: Int = 1
    
    var body: some View {
        NavigationStack {
            Form {
                TextFieldLabel(label: "Title", text: .constant(""))
                
                Picker("Category", selection: $categorySelection) {
                    Text("Drink")
                    Text("Food")
                }
            }
            .navigationTitle("Add Product")
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

struct AddProductScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddProductScreen()
    }
}
