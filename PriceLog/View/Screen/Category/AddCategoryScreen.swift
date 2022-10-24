//
//  AddCategoryScreen.swift
//  PriceLog
//
//  Created by William Santoso on 27/06/22.
//

import SwiftUI

struct AddCategoryScreen: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: AddCategoryViewModel
    
    let onSave: ((Category?) -> Void)?
    let onDelete: (() -> Void)?
    
    init(viewModel: AddCategoryViewModel = AddCategoryViewModel(), onSave: ((Category?) -> Void)? = nil, onDelete: (() -> Void)? = nil) {
        self.viewModel = viewModel
        self.onSave = onSave
        self.onDelete = onDelete
    }
    
    private var screenTitle: String {
        (viewModel.isEdit ? "Edit" : "Add") + " Category"
    }
    
    @State private var title: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextFieldLabel(label: "Name", text: $viewModel.name)
                }
                
                if let onDelete = onDelete {
                    Section {
                        Button("Delete", role: .destructive) {
                            onDelete()
                            dismiss()
                        }
                    }
                }
            }
            .navigationTitle(screenTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .automatic) {
                    Button {
                        viewModel.save { category in
                            onSave?(category)
                            dismiss()
                        }
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
            .hideKeyboardOnTapped()
        }
    }
}

struct AddCategoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryScreen()
    }
}
