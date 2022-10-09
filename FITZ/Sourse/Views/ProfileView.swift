//
//  ProfileView.swift
//  FITZ
//
//  Created by Bogdan Zykov on 18.09.2022.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    var body: some View {
       ScrollView{
            VStack(spacing: 20){
                mainContent
                settingListView
            }
            .padding()
        }
       .onAppear{
           viewModel.onAppear()
       }
       .navigationTitle("Profile")
       .fullScreenCover(isPresented: $viewModel.loginSingupPushed, onDismiss:{
           viewModel.onAppear()
           viewModel.getCurrentUser()
       }) {
           LoginSignupView(mode: .signup, isPushed: $viewModel.loginSingupPushed)
       }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
        }
    }
}

extension ProfileView{
    
    
    private var mainContent: some View{
        Group{
            if viewModel.isAnonUser{
                anonUserView
            }else{
                titleView
                challengeStats
                if !viewModel.isPremium{
                    upgradePremiumBtn
                }
            }
        }
    }
    
    private var titleView: some View{
        HStack {
            Text("Hi, \(viewModel.currentUser?.userName ?? "User")")
                .font(.title.weight(.bold))
                .lineLimit(1)
            Spacer()
            if viewModel.isPremium{
                primiumLabel
            }
        }
        .hLeading()
    }
    private var challengeStats: some View{
        VStack(spacing: 20){
            HStack(alignment: .top){
                statsRow("challenges\ncompleted", 10)
                Spacer()
                statsRow("total\ndays", 50)
                Spacer()
                statsRow("total\nexecise", 10)
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
        .background(Color.primaryButton)
        .cornerRadius(10)
    }
    
    private func statsRow(_ title: String, _ value: Int) -> some View{
        VStack(alignment: .leading, spacing: 10){
            Text("\(value)")
                .font(.title3.weight(.bold))
            Text(title)
        }
    }
    
    private var upgradePremiumBtn: some View{
        Button {
            
        } label: {
            Label {
                Text("Upgrade to premium")
            } icon: {
                Image(systemName: "wand.and.stars.inverse")
            }
            .font(.system(size: 20, weight: .medium))
            .foregroundColor(.black)
            .hCenter()
        }
        .buttonStyle(PrimaryButtonStyle(fillColor: .circleTrack))
    }
    
    private var primiumLabel: some View{
        Text("Premium")
            .font(.caption.weight(.medium))
            .foregroundColor(.black)
            .padding(.horizontal, 15)
            .padding(.vertical, 5)
            .background(Color.circleTrack)
            .cornerRadius(5)
    }
    
}


extension ProfileView{
    
    
    private var anonUserView: some View{
        Group{
            Text("Create an account to keep track of your stats and save your Challenges!")
                .font(.title2.weight(.medium))
                .multilineTextAlignment(.center)
            createAccoutBtn
        }
    }
    
    private var createAccoutBtn: some View{
        Button {
            viewModel.loginSingupPushed.toggle()
        } label: {
            Label {
                Text("Create an account")
            } icon: {
                Image(systemName: "person.crop.circle.badge.plus")
            }
            .font(.system(size: 20, weight: .medium))
            .foregroundColor(.primaryFont)
            .hCenter()
        }
        .buttonStyle(PrimaryButtonStyle())
    }
}

extension ProfileView{
    
    
    private var settingListView: some View{
        ForEach(viewModel.settingItem.indices, id: \.self) { index in
            settingRowView(viewModel.settingItem[index])
        }
    }
    
    
    private func settingRowView(_ item: ProfileViewModel.SettingsItemModel) -> some View{
        Button {
            viewModel.tappedItem(item)
        } label: {
            HStack{
                Image(systemName: item.iconName)
                Text(item.title)
            }
            .foregroundColor(.primary)
            .hLeading()
        }
        .buttonStyle(PrimaryButtonStyle(fillColor: .primaryButton))
    }
}
