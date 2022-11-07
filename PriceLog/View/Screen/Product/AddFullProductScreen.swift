//
//  AddFullProductScreen.swift
//  PriceLog
//
//  Created by William Santoso on 07/11/22.
//

import SwiftUI

struct AddFullProductScreen: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = AddFullProductViewModel()
    
    @State private var isShowAlertRequest = false
    @State private var isShowDiscardAlert: Bool = false
    @State private var isShowAddProduct: Bool = false
    @State private var isShowAddProductType: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Product")  {
                    if !viewModel.productsVM.isEmpty {
                        Picker("Select Product", selection: $viewModel.selectedProductIndex) {
                            ForEach(viewModel.productsVM.indices, id: \.self) { index in
                                Text(viewModel.productsVM[index].product.name)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    
                    Button("Add Product") {
                        isShowAddProduct.toggle()
                    }
                }
                
                Section("Type")  {
                    if !viewModel.productTypesVM.isEmpty {
                        Picker("Select Type", selection: $viewModel.selectedProductTypeIndex) {
                            ForEach(viewModel.productTypesVM.indices, id: \.self) { index in
                                Text(viewModel.productTypesVM[index].name)
                            }
                        }
                        .pickerStyle(.menu)
                    } else {
                        Text("No Product Type")
                    }
                    
                    Button("Add Type") {
                        isShowAddProductType.toggle()
                    }
                }
                
                Section("Price") {
                    NumberFieldLabel(label: "Price", text: $viewModel.priceString)

                    Picker("Store", selection: $viewModel.selectedStoreIndex) {
                        ForEach(viewModel.storesVM.indices, id: \.self) { index in
                            Text(viewModel.storesVM[index].store.name)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    DatePicker("Date", selection: $viewModel.date, displayedComponents: .date)
                }
            }
            .onAppear {
                viewModel.getData()
            }
            .navigationTitle("Add Product")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .automatic) {
                    Button {
                        viewModel.save {
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
            .sheet(isPresented: $isShowAddProduct, onDismiss: {
                viewModel.getData()
            }, content: {
                AddProductScreen()
            })
            .sheet(isPresented: $isShowAddProductType, onDismiss: {
                viewModel.getData()
            }, content: {
                AddProductTypeScreen(viewModel: AddProductTypeViewModel(productId: viewModel.selectedProductId))
            })
            .discardChangesAlert(isShowAlert: $isShowDiscardAlert) {
                dismiss()
            }
            .hideKeyboardOnTapped()
        }
    }
}

struct AllFullProductScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddFullProductScreen()
    }
}
