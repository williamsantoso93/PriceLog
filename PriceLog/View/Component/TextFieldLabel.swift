//
//  TextFieldLabel.swift
//  PriceLog
//
//  Created by William Santoso on 02/07/22.
//

import SwiftUI

struct TextFieldLabel: View {
    let label: String
    var promp: String = ""
    @Binding var text: String
    var unit: String = ""
    
    var body: some View {
        HStack {
            Text(label)
            
            TextField(text: $text) {
                Text(promp)
            }
            .multilineTextAlignment(.trailing)
            
            if !unit.isEmpty {
                Text(unit)
            }
        }
    }
}

struct TextFieldLabel_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TextFieldLabel(label: "Title", text: .constant(""))
            TextFieldLabel(label: "Title", promp: "Cereal", text: .constant(""))
            TextFieldLabel(label: "Title", text: .constant(""), unit: "g")
            TextFieldLabel(label: "Title", promp: "Cereal", text: .constant(""), unit: "g")
        }
        .padding()
    }
}
