//
//  CreateModalView.swift
//  FITZ
//
//  Created by Bogdan Zykov on 18.09.2022.
//

import SwiftUI

struct CreateChallengeModalView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    var body: some View {
        NavigationView{
            CreateView()
        }
        .accentColor(.primary)
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

struct CreateModalView_Previews: PreviewProvider {
    static var previews: some View {
        CreateChallengeModalView()
    }
}
