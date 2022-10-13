//
//  LaunchScreenView.swift
//  FITZ
//
//  Created by Bogdan Zykov on 13.10.2022.
//

import SwiftUI

struct LaunchScreenView: View {
    @Binding var isActive: Bool
    var body: some View {
        ZStack{
            Color.launchBg
                .ignoresSafeArea()
                Text("FITZ")
                .foregroundColor(.white)
                .font(.system(size: 70).weight(.bold))
        }
        .onAppear{
            withAnimation(.easeInOut(duration: 0.3).delay(1)) {
                isActive = true
            }
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView(isActive: .constant(true))
    }
}
