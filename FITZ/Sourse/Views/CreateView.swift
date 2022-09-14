//
//  CreateView.swift
//  FITZ
//
//  Created by Bogdan Zykov on 14.09.2022.
//

import SwiftUI

struct CreateView: View {
    @StateObject private var viewModel = CreateChallengeViewModel()
    var body: some View {
        ScrollView {
            VStack(spacing: 10){
                dropDownList
//                NavigationLink(isActive: $showRemindView) {
//                    RemindView()
//                } label: {
//                    
//                }
                nexButton
            }
            .navigationTitle("Create")
        .navigationBarBackButtonHidden(true)
        }
        .confirmationDialog("Select", isPresented: Binding<Bool>(get: {viewModel.hasSelectedDropdown}, set: { _ in })) {
            confirmContent
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
            viewModel.send(.createChallenge)
        } label: {
            Text("Create")
                .font(.system(size: 24, weight: .medium))
        }
    }
    
    private var confirmContent: some View{
        Group {
            ForEach(viewModel.displayedOption.indices, id: \.self){ index in
                Button(viewModel.displayedOption[index].formatted, action: {
                    viewModel.send(.selectOption(index: index))
                    
                })
            }
            Button("Cancel", role: .cancel, action: viewModel.clearIsSelectedAllDropdowns)
        }
    }
}
