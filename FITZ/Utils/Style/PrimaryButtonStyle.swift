//
//  PrimaryButtonStyle.swift
//  FITZ
//
//  Created by Bogdan Zykov on 14.09.2022.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle{
    var fillColor: Color = .darkPrimaryButton
    func makeBody(configuration: Configuration) -> some View {
        return PrimaryButton(
            configuration: configuration,
            fillColor: fillColor)
    }
    
    struct PrimaryButton: View{
        let configuration: Configuration
        let fillColor: Color
        var body: some View{
            
            return configuration.label
                .padding(20)
                .background(RoundedRectangle(cornerRadius: 8).fill(fillColor))
                .opacity(configuration.isPressed ? 0.6 : 1)
        }
    }
}
