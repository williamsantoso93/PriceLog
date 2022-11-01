//
//  AddProductTypeScreen.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import SwiftUI
import CoreData

struct AddProductTypeScreen: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: AddProductTypeViewModel
    
    let onSave: (() -> Void)?
    let onDelete: (() -> Void)?
    
    init(viewModel: AddProductTypeViewModel, onSave: (() -> Void)? = nil, onDelete: (() -> Void)? = nil) {
        self.viewModel = viewModel
        self.onSave = onSave
        self.onDelete = onDelete
    }
    
    private var screenTitle: String {
        (viewModel.isEdit ? "Edit" : "Add") + " Product Type"
    }
    @State private var isShowDiscardAlert: Bool = false
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextFieldLabel(label: "Name", text: $viewModel.name)
                    Picker("Unit", selection: $viewModel.unitType) {
                        ForEach(UnitType.allCases, id: \.self) { unitType in
                            Text(viewModel.getUnitTitle(unitType: unitType))
                        }
                    }
                    .pickerStyle(.menu)
                    TextFieldLabel(label: viewModel.unitType.getValueTitle(), text: $viewModel.unitString)
                }
                
                if let onDelete = onDelete, viewModel.isEdit {
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
                        viewModel.save {
                            onSave?()
                            dismiss()
                        }
                    } label: {
                        Text("Save")
                    }
                }
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button {
                        if viewModel.isChange {
                            isShowDiscardAlert = true
                        } else {
                            dismiss()
                        }
                    } label: {
                        Text("Cancel")
                    }
                }
            }
            .discardChangesAlert(isShowAlert: $isShowDiscardAlert) {
                dismiss()
            }
            .hideKeyboardOnTapped()
        }
    }
}

struct AddProductTypeScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddProductTypeScreen(viewModel: AddProductTypeViewModel(productId: NSManagedObjectID()))
    }
}
