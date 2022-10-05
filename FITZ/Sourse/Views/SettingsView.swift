//
//  SettingsView.swift
//  FITZ
//
//  Created by Bogdan Zykov on 18.09.2022.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var settingVM = SettingsViewModel()
    var body: some View {
        List(settingVM.settingItem.indices, id: \.self) { index in
            settingRowView(settingVM.settingItem[index])
        }
        .navigationTitle("Settings")
        .background{
            NavigationLink(isActive: $settingVM.loginSingupPushed) {
                LoginSignupView(viewModel: LoginSignupViewModel(mode: .signup, isPushed: $settingVM.loginSingupPushed))
            } label: {
                EmptyView()
            }
        }
        .onAppear{
            settingVM.onAppear()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
        }
    }
}

extension SettingsView{
    
    private func settingRowView(_ item: SettingsViewModel.SettingsItemModel) -> some View{
        Button {
            settingVM.tappedItem(item)
        } label: {
            HStack{
                Image(systemName: item.iconName)
                Text(item.title)
            }
            .foregroundColor(.primary)
        }
    }
}
