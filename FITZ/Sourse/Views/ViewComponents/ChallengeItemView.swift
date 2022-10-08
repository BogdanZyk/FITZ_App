//
//  ChallengeItemView.swift
//  FITZ
//
//  Created by Bogdan Zykov on 16.09.2022.
//

import SwiftUI

struct ChallengeItemView: View {
    let challengeItem: ChallengeItemModel
    var body: some View {
        HStack{
            Spacer()
            VStack{
                titleRowView
                ProgressCircleView(progressModel: challengeItem.progressCircleModel)
                    .padding(25)
                daylyIncreaseRow
            }
            .padding(.vertical, 10)
            Spacer()
        }
        
        .background(
            Rectangle().fill(Color.primaryButton)
                .cornerRadius(5)
        )
    }
}

struct ChallengeItemView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeItemView(challengeItem: ChallengeItemModel(Challenge(exercise: "situps", startAmount: 4, increase: 4, lenght: 21, userId: "", startDate: Date()), onDelete: { _ in}))
            .preferredColorScheme(.dark)
    }
}

extension ChallengeItemView{
    private var titleRowView: some View{
        HStack {
            Text(challengeItem.title)
                .font(.system(size: 24, weight: .bold))
            Spacer()
            
            Button {
                challengeItem.tappedDelete()
            } label: {
                Image(systemName: "trash")
            }
        }
    }
    
    private var daylyIncreaseRow: some View{
        HStack {
            Text(challengeItem.dayilyIncreaseText)
                .font(.subheadline.weight(.semibold))
            Spacer()
        }
    }
}
