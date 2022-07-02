//
//  AddCategoryScreen.swift
//  PriceLog
//
//  Created by William Santoso on 27/06/22.
//

import SwiftUI

struct AddCategoryScreen: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                TextFieldLabel(label: "Title", text: .constant(""))
            }
            .navigationTitle("Add Category")
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

struct AddCategoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryScreen()
    }
}
