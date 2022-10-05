//
//  ProgressCircleView.swift
//  FITZ
//
//  Created by Bogdan Zykov on 05.10.2022.
//

import SwiftUI

struct ProgressCircleView: View {
    let progressModel: ProgressCircleModel
    @State private var persantage: CGFloat = 0
    var body: some View {
        ZStack{
            Circle()
                .stroke(style: .init(lineWidth: 15, lineCap: .round, lineJoin: .round))
                .fill(Color.circleOutline)
            Circle()
                .trim(from: 0, to: persantage)
                .stroke(style: .init(lineWidth: 15, lineCap: .round, lineJoin: .round))
                .fill(Color.circleTrack)
                .rotationEffect(.init(degrees: -90))
            VStack{
                if progressModel.shouldShowTitle{
                    Text(progressModel.title)
                }
                Text(progressModel.message)
            }
            .padding(25)
            .font(.callout.weight(.semibold))
        }
        .onAppear{
            withAnimation(.spring(response: 3)) {
                persantage = CGFloat(progressModel.persentageComplete)
            }
        }
    }
}

struct ProgressCircleView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressCircleView(progressModel: .init(title: "Day", message: "3 of 7", persentageComplete: 0.43))
            .frame(width: 200, height: 200)
    }
}
