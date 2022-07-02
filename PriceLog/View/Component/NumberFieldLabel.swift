//
//  NumberFieldLabel.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import SwiftUI

struct NumberFieldLabel: View {
    let label: String
    var promp: String = ""
    @Binding var text: String
    var unit: String = ""
    
    var body: some View {
        TextFieldLabel(label: label, promp: promp, text: $text, unit: unit)
            .onChange(of: text, perform: { value in
                self.text = value.splitDigitDouble()
            })
            .keyboardType(.decimalPad)
    }
}

struct NumberFieldLabel_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            NumberFieldLabel(label: "Title", text: .constant(""))
            NumberFieldLabel(label: "Title", promp: "Cereal", text: .constant(""))
            NumberFieldLabel(label: "Title", text: .constant(""), unit: "g")
            NumberFieldLabel(label: "Title", promp: "Cereal", text: .constant(""), unit: "g")
        }
        .padding()
    }
}
