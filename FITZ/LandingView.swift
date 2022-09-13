//
//  LandingView.swift
//  FITZ
//
//  Created by Bogdan Zykov on 13.09.2022.
//

import SwiftUI

struct LandingView: View {
    var body: some View {
        GeometryReader { proxy in
            VStack{
                Spacer().frame(height: proxy.size.height * 0.3)
                Text("Welcome to FitzApp")
                    .font(.system(size: 35, weight: .medium))
                    .foregroundColor(.white)
                Spacer()
               
                actionButton
            }
            .allFrame()
            .background{
                Image("landing2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .overlay(Color.black.opacity(0.4))
                    .frame(width: proxy.size.width)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}


extension LandingView{
    private var actionButton: some View{
        Button {
            
        } label: {
            HStack{
                Image(systemName: "plus.circle")
                Text("Create a challenge")
            }
            .font(.system(size: 24, weight: .semibold))
            .foregroundColor(.white)
            .hCenter()
        }
        .buttonStyle(PrimaryButtonStyle())
        .padding(.horizontal)
    }
}
