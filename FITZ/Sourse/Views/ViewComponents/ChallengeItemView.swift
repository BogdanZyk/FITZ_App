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
                Text(challengeItem.title)
                    .font(.system(size: 24, weight: .bold))
                Text(challengeItem.statusText)
                Text(challengeItem.dayilyIncreaseText)
            }
            .padding()
            Spacer()
        }
       
        .background(
            Rectangle().fill(Color.darkPrimaryButton)
                .cornerRadius(5)
        )
        .padding()
    }
}

struct ChallengeItemView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeItemView(challengeItem: ChallengeItemModel(Challenge(exercise: "situps", startAmount: 4, increase: 4, lenght: 21, userId: "", startDate: Date())))
    }
}
