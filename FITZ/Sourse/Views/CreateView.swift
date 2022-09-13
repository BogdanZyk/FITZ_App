//
//  CreateView.swift
//  FITZ
//
//  Created by Bogdan Zykov on 14.09.2022.
//

import SwiftUI

struct CreateView: View {
    @StateObject private var viewModel = CreateChallengeViewModel()
    @State private var showRemindView: Bool = false
    var body: some View {
        ScrollView {
            VStack(spacing: 10){
                dropDownList
                NavigationLink(isActive: $showRemindView) {
                    RemindView()
                } label: {
                    nexButton
                }
            }
            .navigationTitle("Create")
        .navigationBarBackButtonHidden(true)
        }
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}


extension CreateView{
    
    private var dropDownList: some View{
        ForEach(viewModel.dropdowns.indices, id: \.self) { index in
            DropdownView(dropdown: $viewModel.dropdowns[index])
        }
    }
    
    private var nexButton: some View{
        Button {
            showRemindView.toggle()
        } label: {
            Text("Next")
                .font(.system(size: 24, weight: .medium))
        }
    }
}
