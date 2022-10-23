//
//  AddCategoryScreen.swift
//  PriceLog
//
//  Created by William Santoso on 27/06/22.
//

import SwiftUI

struct AddCategoryScreen: View {
    @Environment(\.dismiss) var dismiss
    
    let isEdit: Bool = false
    private var screenTitle: String {
        (isEdit ? "Edit" : "Add") + " Category"
    }
    
    @State private var title: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextFieldLabel(label: "Title", text: $title)
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

struct AddCategoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryScreen()
    }
}
