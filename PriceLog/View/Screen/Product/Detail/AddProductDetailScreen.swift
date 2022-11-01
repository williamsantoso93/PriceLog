//
//  AddProductDetailScreen.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import SwiftUI
import CoreData

struct AddProductDetailScreen: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: AddProductDetailPriceViewModel
    
    let onSave: (() -> Void)?
    let onDelete: (() -> Void)?
    
    init(viewModel: AddProductDetailPriceViewModel, onSave: (() -> Void)? = nil, onDelete: (() -> Void)? = nil) {
        self.viewModel = viewModel
        self.onSave = onSave
        self.onDelete = onDelete
    }
    
    private var screenTitle: String {
        (viewModel.isEdit ? "Edit" : "Add") + " Product Detail"
    }
    @State private var isShowDiscardAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    NumberFieldLabel(label: "Price", text: $viewModel.priceString)
                    
                    Picker("Store", selection: $viewModel.locationStore) {
                        ForEach(viewModel.storesVM.indices, id: \.self) { index in
                            Text(viewModel.storesVM[index].store.name)
                        }
                    }
                    .pickerStyle(.menu)
                    DatePicker("Date", selection: $viewModel.date, displayedComponents: .date)
                }
                Section {
                    NavigationLink {
                        StoreScreen()
                    } label: {
                        Text("Stores")
                    }
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
            .onAppear {
                viewModel.getStores()
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

struct AddProductDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddProductDetailScreen(viewModel: AddProductDetailPriceViewModel(productTypeId: NSManagedObjectID()))
    }
}
