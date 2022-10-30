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
    
    init(viewModel: AddProductViewModel, onSave: ((Product?) -> Void)? = nil, onDelete: (() -> Void)? = nil) {
        self.viewModel = viewModel
        self.onSave = onSave
        self.onDelete = onDelete
    }
    
    private var screenTitle: String {
        (viewModel.isEdit ? "Edit" : "Add") + " Product"
    }
    
    @State private var sourceType: ImagePicker.SourceType = .photoLibrary
    @State private var requestAccessType: RequestType = .photos
    @State private var isShowImagePicker = false
    @State private var isShowAlertRequest = false
    @State private var isShowDiscardAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    ZStack(alignment: .center) {
                        if let image = viewModel.image {
                            Image(uiImage: image)
                        } else {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.blue, lineWidth: 2)
                            
                            Button {
                                imagePicker()
                            } label: {
                                Image(systemName: "camera")
                                    .font(.title)
                            }
                        }
                    }
                    .frame(height: 175)
                    
                    TextFieldLabel(label: "Name", text: $viewModel.name)
//                    Picker("Category", selection: $viewModel.categorySelection) {
//                        ForEach(viewModel.categories.indices, id: \.self) { index in
//                            Text(viewModel.categories[index])
//                        }
//                    }
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
            .sheet(isPresented: $isShowImagePicker) {
                ImagePicker(sourceType: sourceType) { image in
                    viewModel.image = image
                    isShowImagePicker = false
                }
            }
            .discardChangesAlert(isShowAlert: $isShowDiscardAlert) {
                dismiss()
            }
            .hideKeyboardOnTapped()
        }
    }
    
    func imagePicker() {
        sourceType = .photoLibrary
        RequestAccess.PhotosAccess { status in
            switch status {
            case .success:
                isShowImagePicker.toggle()
            case .notAllow:
                break
            case .decline:
                requestAccessType = .photos
                isShowAlertRequest.toggle()
            }
        }
    }

}

//struct AddProductScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        AddProductScreen()
//    }
//}
