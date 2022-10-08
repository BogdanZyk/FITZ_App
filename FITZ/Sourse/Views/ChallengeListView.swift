//
//  ChallengeListView.swift
//  FITZ
//
//  Created by Bogdan Zykov on 16.09.2022.
//

import SwiftUI

struct ChallengeListView: View {
    @EnvironmentObject var challengeVM: ChallengeListViewModel
    let columns: [GridItem] = Array.init(repeating: GridItem(.flexible(), spacing: 10), count: 2)
    var body: some View {
        ZStack{
            if challengeVM.isLoading{
                ProgressView()
            }else if let error = challengeVM.error{
                errorView(error)
            }else{
                mainContentView
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.significantTimeChangeNotification)) { _ in
                        
                    }
            }
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Challenges")
    }
}


struct ChallengeListView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeListView()
            .preferredColorScheme(.dark)
            .environmentObject(ChallengeListViewModel())
    }
}

extension ChallengeListView{
    private var mainContentView: some View{
        ScrollView{
            LazyVGrid(columns: columns) {
                ForEach(challengeVM.itemModels, id: \.id){item in
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
