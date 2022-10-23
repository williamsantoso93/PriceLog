//
//  AddProductScreen.swift
//  PriceLog
//
//  Created by William Santoso on 27/06/22.
//

import SwiftUI

struct AddProductScreen: View {
    @Environment(\.dismiss) private var dismiss
    
    let isEdit: Bool = false
    private var screenTitle: String {
        (isEdit ? "Edit" : "Add") + " Product"
    }
    
    @State private var productTitle: String = ""
    
    @State private var categorySelection: Int = 0
    //TODO: change to actual data
    private let categories: [String] = [
        "Drink",
        "Food"
    ]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextFieldLabel(label: "Title", text: $productTitle)
                    Picker("Category", selection: $categorySelection) {
                        ForEach(categories.indices, id: \.self) { index in
                            Text(categories[index])
                        }
                    }
                }
                
                if isEdit {
                    Section {
                        Button("Delete", role: .destructive) {
                            //TODO: delete action
                        }
                    }
                }
            }
            .navigationTitle(screenTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .automatic) {
                    Button {
                        //TODO: save action
                        
                        dismiss()
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
