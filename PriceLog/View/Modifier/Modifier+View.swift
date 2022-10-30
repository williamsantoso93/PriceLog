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

struct DiscardChangesAlert: ViewModifier {
    @Binding var isShowAlert: Bool
    
    let discard: () -> Void
    
    func body(content: Content) -> some View {
        content
            .alert("Discard Changes", isPresented: $isShowAlert) {
                Button("Discard", role: .destructive) {
                    isShowAlert = false
                    discard()
                }
            } message: {
                Text("Do you want to discard your changes?")
            }

    }
}

extension View {
    func hideKeyboardOnTapped() -> some View {
        modifier(HideKeyboardOnTapped())
    }
    
    func discardChangesAlert(isShowAlert: Binding<Bool>, discard: @escaping () -> Void) -> some View {
        modifier(DiscardChangesAlert(isShowAlert: isShowAlert, discard: discard))
    }
}
