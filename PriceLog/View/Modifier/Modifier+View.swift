//
//  ViewModifier.swift
//  PriceLog
//
//  Created by William Santoso on 24/10/22.
//

import SwiftUI

struct HideKeyboardOnTapped: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                #if canImport(UIKit)
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                #endif
            }
    }
}

extension View {
    func hideKeyboardOnTapped() -> some View {
        modifier(HideKeyboardOnTapped())
    }
}
