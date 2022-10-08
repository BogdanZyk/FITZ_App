//
//  LandingView.swift
//  FITZ
//
//  Created by Bogdan Zykov on 13.09.2022.
//

import SwiftUI

struct LandingView: View {
    @StateObject private var landingVM = LandingViewModel()
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                VStack{
                    Spacer().frame(height: proxy.size.height * 0.3)
                    welcomeTitle
                    Spacer()
                
                    actionButton
                    alreadyButton
                    NavigationLink(isActive: $landingVM.loginSingupPushed, destination:{ LoginSignupView(mode: .login, isPushed: $landingVM.loginSingupPushed) }){}
                    
                    NavigationLink(isActive: $landingVM.createPushed, destination: { CreateView() }){}
                }
                .allFrame()
                .background(bgImage(proxy))
            }
        }
        .accentColor(.primary)
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}


extension LandingView{
    
    private var welcomeTitle: some View{
        VStack(spacing: 20) {
            Text("Welcome to FitzApp")
                .font(.system(size: 35, weight: .medium))
            Text("Create a sports challenge and complete it!")
                .font(.system(size: 25, weight: .medium))
                .multilineTextAlignment(.center)
        }
        .foregroundColor(.white)
    }
    
    private func bgImage(_ proxy: GeometryProxy) -> some View{
        Image("landing2")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .overlay(Color.black.opacity(0.4))
            .frame(width: proxy.size.width)
            .edgesIgnoringSafeArea(.all)
    }
    
    private var actionButton: some View{
        Button {
            landingVM.createPushed.toggle()
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
    
    private var alreadyButton: some View{
        Button {
            landingVM.loginSingupPushed.toggle()
        } label: {
            Text("I already have an account")
                .foregroundColor(.white)
        }.padding(.vertical, 10)

    }
}
