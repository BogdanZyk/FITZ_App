//
//  ErrorHandler.swift
//  FITZ
//
//  Created by Bogdan Zykov on 09.10.2022.
//

import SwiftUI

public struct ErrorHandleModifier: ViewModifier {
    @Binding var isPresented: Bool
    var message: String?

    public func body(content: Content) -> some View {
        content
            .alert("Error", isPresented: $isPresented) {
                Button("Ok", role: .cancel, action: {})
            } message: {
                Text(message ?? "")
            }
    }
}

extension View {
    public func handle(isPresented: Binding<Bool>, message: String?) -> some View {
        modifier(ErrorHandleModifier(isPresented: isPresented, message: message))
    }
}



