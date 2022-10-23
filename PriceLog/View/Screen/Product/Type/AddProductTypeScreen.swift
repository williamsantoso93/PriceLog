//
//  AddProductTypeScreen.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import SwiftUI

struct AddProductTypeScreen: View {
    @Environment(\.dismiss) private var dismiss
    @State private var name: String = ""
    @State private var unitSelection: UnitType = .kg
    
    @State private var valueString: String = ""
    private var value: Double {
        Double(valueString) ?? 0
    }
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextFieldLabel(label: "Name", text: $name)
                    Picker("Unit", selection: $unitSelection) {
                        ForEach(UnitType.allCases, id: \.self) { unit in
                            Text("\(unit.getTitle(by: value))")
                        }
                    }
                    TextFieldLabel(label: unitSelection.getValueTitle(), text: $valueString)
                }
                
                Section {
                    Button("Delete", role: .destructive) {
                        
                    }
                }
            }
            .navigationTitle("Add Product Type")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .automatic) {
                    Button {
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

struct AddProductTypeScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddProductTypeScreen()
    }
}
