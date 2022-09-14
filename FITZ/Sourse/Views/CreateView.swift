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
        ZStack{
            if viewModel.isLoading{
                ProgressView()
            }else{
                mainContentView
            }
        }
        .alert("Error!", isPresented: Binding<Bool>.constant($viewModel.error.wrappedValue != nil), actions: {
            Button("OK") {viewModel.error = nil}
        }, message: {
            Text(viewModel.error?.localizedDescription ?? "")
        })
        .navigationTitle("Create")
        .navigationBarBackButtonHidden(true)
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}

extension CreateView{
    private var mainContentView: some View{
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
        }
    }
}

extension CreateView{
    
    private var dropDownList: some View{
        Group{
            DropdownView(dropdown: $viewModel.exerciseDropdowns)
            DropdownView(dropdown: $viewModel.startDropdowns)
            DropdownView(dropdown: $viewModel.increaseDropdowns)
            DropdownView(dropdown: $viewModel.lengthDropdowns)
            
        }
//        ForEach(viewModel.dropdowns.indices, id: \.self) { index in
//            DropdownView(dropdown: $viewModel.dropdowns[index])
//        }
    }
    
    private var nexButton: some View{
        Button {
            viewModel.send(.createChallenge)
        } label: {
            Text("Create")
                .font(.system(size: 24, weight: .medium))
        }
    }
    

}
