//
//  ChallengeListView.swift
//  FITZ
//
//  Created by Bogdan Zykov on 16.09.2022.
//

import SwiftUI

struct ChallengeListView: View {
    @StateObject private var challengeVM = ChallengeListViewModel()
    var body: some View {
        NavigationView {
            ScrollView{
                LazyVGrid(columns: Array.init(repeating: GridItem(.flexible()), count: 2)) {
                    ForEach(challengeVM.itemModels, id: \.self){item in
                        ChallengeItemView(challengeItem: item)
                    }
                }
            }.navigationTitle("Challenges")
        }
    }
}

struct ChallengeListView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeListView()
    }
}
