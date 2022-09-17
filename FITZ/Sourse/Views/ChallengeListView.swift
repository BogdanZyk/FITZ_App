//
//  ChallengeListView.swift
//  FITZ
//
//  Created by Bogdan Zykov on 16.09.2022.
//

import SwiftUI

struct ChallengeListView: View {
    @StateObject private var challengeVM = ChallengeListViewModel()
    let columns: [GridItem] = Array.init(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    var body: some View {
        NavigationView {
            ZStack{
                if challengeVM.isLoading{
                    ProgressView()
                }else if let error = challengeVM.error{
                    errorView(error)
                }else{
                    mainContentView
                }
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        challengeVM.send(.create)
                    } label: {
                        Image(systemName: "plus.circle").imageScale(.large)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Challenges")
            .sheet(isPresented: $challengeVM.showCreateModal) {
                NavigationView{
                    CreateView()
                }
            }
        }
    }
}


struct ChallengeListView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeListView()
            .preferredColorScheme(.dark)
    }
}

extension ChallengeListView{
    private var mainContentView: some View{
        ScrollView{
            LazyVGrid(columns: columns) {
                ForEach(challengeVM.itemModels, id: \.self){item in
                    ChallengeItemView(challengeItem: item)
                }
            }
            .padding()
        }
    }
    
    private func errorView(_ error: FitzError) -> some View{
        VStack{
            Text(error.localizedDescription)
            Button("Retry") {
                challengeVM.send(.retry)
            }
            .padding(10)
            .background(Rectangle().fill(Color.red).cornerRadius(5))
        }
    }
}
