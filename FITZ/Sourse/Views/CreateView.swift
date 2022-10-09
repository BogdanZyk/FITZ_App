//
//  CreateView.swift
//  FITZ
//
//  Created by Bogdan Zykov on 14.09.2022.
//

import SwiftUI

struct CreateView: View {
    @State private var showTfExercise: Bool = false
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
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
               toolbarBtn
            }
        }
        .navigationTitle("Create challenge")
        .navigationBarBackButtonHidden(true)
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateView()
        }
    }
}

extension CreateView{
    private var mainContentView: some View{
        ScrollView {
            VStack(spacing: 10){
                dropDownList
                nexButton
            }
        }
    }
}

extension CreateView{
    
    private var dropDownList: some View{
        Group{
            DropdownView(dropdown: $viewModel.exerciseDropdowns)
            if showTfExercise{
                exerciseTextField
            }
            DropdownView(dropdown: $viewModel.startDropdowns)
            DropdownView(dropdown: $viewModel.increaseDropdowns)
            DropdownView(dropdown: $viewModel.lengthDropdowns)
            
        }
    }
    
    private var nexButton: some View{
        Button {
            viewModel.send(.createChallenge)
        } label: {
            Text("Create")
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.primary)
                .hCenter()
        }
        .buttonStyle(PrimaryButtonStyle())
        .padding(.horizontal)
    }
    
    private var exerciseTextField: some View{
        TextField("Exercise", text: $viewModel.customExerciseText)
            .modifier(TextFieldCustomRoundedStyle())
            .textInputAutocapitalization(.never)
            .padding(.horizontal)
    }
    
    private var toolbarBtn: some View{
        
        Button(showTfExercise ? "Save" : "Custom exercise") {
            
            if showTfExercise{
                viewModel.send(.setCustomExercise)
            }
            
            withAnimation {
                showTfExercise.toggle()
            }
        }
        .animation(nil, value: UUID())
    }

}
