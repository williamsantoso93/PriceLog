//
//  AddProductScreen.swift
//  PriceLog
//
//  Created by William Santoso on 27/06/22.
//

import SwiftUI

struct AddProductScreen: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: AddProductViewModel
    
    let onSave: ((Product?) -> Void)?
    let onDelete: (() -> Void)?
    
    init(viewModel: AddProductViewModel = AddProductViewModel(), onSave: ((Product?) -> Void)? = nil, onDelete: (() -> Void)? = nil) {
        self.viewModel = viewModel
        self.onSave = onSave
        self.onDelete = onDelete
    }
    
    private var screenTitle: String {
        (viewModel.isEdit ? "Edit" : "Add") + " Product"
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextFieldLabel(label: "Name", text: $viewModel.name)
//                    Picker("Category", selection: $viewModel.categorySelection) {
//                        ForEach(viewModel.categories.indices, id: \.self) { index in
//                            Text(viewModel.categories[index])
//                        }
//                    }
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
                        viewModel.save { product in
                            onSave?(product)
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

struct AddProductScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddProductScreen()
    }
}
