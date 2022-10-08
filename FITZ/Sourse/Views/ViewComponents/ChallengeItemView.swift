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
            VStack(spacing: 8){
                titleRowView
                ProgressCircleView(progressModel: challengeItem.progressCircleModel)
                    .padding(25)
                daylyIncreaseRow
                todayView
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
        HStack(spacing: 10) {
            ChallengeItemView(challengeItem: ChallengeItemModel(Challenge(exercise: "situps", startAmount: 4, increase: 4, lenght: 21, userId: "", startDate: Date(), activities: [.init(date: Date(), isComplete: true)]), onDelete: { _ in}, onToggleComplete: {_, _ in}))
            ChallengeItemView(challengeItem: ChallengeItemModel(Challenge(exercise: "situps", startAmount: 4, increase: 4, lenght: 21, userId: "", startDate: Date(), activities: [.init(date: Date(), isComplete: false)]), onDelete: { _ in}, onToggleComplete: {_, _ in}))
               
        }
        //.preferredColorScheme(.dark)
    }
}

extension ChallengeItemView{
    private var titleRowView: some View{
        HStack {
            Text(challengeItem.title)
                .font(.system(size: 24, weight: .bold))
            Spacer()
            
            Button {
                challengeItem.send(.delete)
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
            if challengeItem.isComplete{
                Text("Days \(challengeItem.challengeLenght)")
                    .font(.subheadline.weight(.medium))
            }
        }
    }
    
    private var todayView: some View{
        Group{
            let isDayComplete = challengeItem.isDayComplete
            let isDoneChallenge = challengeItem.isComplete
            Divider()
            if isDoneChallenge{
                VStack(spacing: 8){
                    Text("Challenge")
                    Text("Completed!")
                }
                .hCenter()
                .font(.system(size: 18, weight: .bold))
           
                
            }else{
                HStack{
                    VStack(alignment: .leading, spacing: 8){
                        Text(challengeItem.todayTitle)
                            .font(.system(size: 18, weight: .medium))
                            .hLeading()
                        Text(challengeItem.toadyRepTitle)
                            .font(.system(size: 18, weight: .bold))
                    }
                    Spacer()
                    Button {
                        challengeItem.send(.toggleComplete)
                    } label: {
                        Image(systemName: "checkmark")
                            .padding(.vertical, 12)
                            .padding(.horizontal, 18)
                            .font(.subheadline.weight(.semibold))
                            .foregroundColor(isDayComplete ? .black : .gray)
                            .background(isDayComplete ? Color.circleTrack : Color.primaryButton)
                            .cornerRadius(8)
                    }
                }
            }
        }
    }
}



