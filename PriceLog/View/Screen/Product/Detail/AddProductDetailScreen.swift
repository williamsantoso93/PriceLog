//
//  AddProductDetailScreen.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import SwiftUI

struct AddProductDetailScreen: View {
    @Environment(\.dismiss) private var dismiss
    
    let isEdit: Bool = false
    private var screenTitle: String {
        (isEdit ? "Edit" : "Add") + " Product Detail"
    }
    
    @State private var priceString: String = ""
    private var price: Double {
        Double(priceString) ?? 0
    }
    
    @State private var locationSelection: Int = 0
    //TODO: change to actual data
    private let locations: [String] = [
        "Superindo",
        "Indomaret"
    ]
    
    @State private var date: Date = Date()
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    NumberFieldLabel(label: "Price", text: $priceString)
                    
                    Picker("Location", selection: $locationSelection) {
                        ForEach(locations.indices, id: \.self) { index in
                            Text(locations[index])
                        }
                    }
                    DatePicker("Date", selection: $date, displayedComponents: .date)
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

struct AddProductDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddProductDetailScreen()
    }
}
