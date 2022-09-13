//
//  RemindView.swift
//  FITZ
//
//  Created by Bogdan Zykov on 14.09.2022.
//

import SwiftUI

struct RemindView: View {
    var body: some View {
        VStack(spacing: 0){
            //DropdownView(
            Spacer()
            VStack(spacing: 15) {
                createButton
                skipButton
            }.foregroundColor(.primary)
            
        }
        .navigationTitle("Remind")
        .navigationBarBackButtonHidden(true)
    }
}

struct RemindView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RemindView()
        }
    }
}

extension RemindView{
    private var createButton: some View{
        Button {
            
        } label: {
            Text("Create")
                .font(.system(size: 24, weight: .medium))
        }
    }
    
    private var skipButton: some View{
        Button {
            
        } label: {
            Text("Skip")
                .font(.system(size: 20, weight: .medium))
        }
    }
}
