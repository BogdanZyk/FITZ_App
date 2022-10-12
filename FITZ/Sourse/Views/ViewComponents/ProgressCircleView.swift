//
//  ProgressCircleView.swift
//  FITZ
//
//  Created by Bogdan Zykov on 05.10.2022.
//

import SwiftUI

struct ProgressCircleView: View {
    let progressModel: ProgressCircleModel
    var size: Size = .large
    @State private var persantage: CGFloat = 0
    var body: some View {
        ZStack{
            Circle()
                .stroke(style: .init(lineWidth: size.lineWidth, lineCap: .round, lineJoin: .round))
                .fill(Color.circleOutline)
            Circle()
                .trim(from: 0, to: persantage)
                .stroke(style: .init(lineWidth: size.lineWidth, lineCap: .round, lineJoin: .round))
                .fill(Color.circleTrack)
                .rotationEffect(.init(degrees: -90))
            VStack{
                if progressModel.shouldShowTitle{
                    Text(progressModel.title)
                }
                Text(progressModel.message)
            }
            .padding(25)
            .font(size.font)
        }
        .onAppear{
            withAnimation(.spring(response: 3)) {
                persantage = CGFloat(progressModel.persentageComplete)
            }
        }
        .frame(minWidth: size.frameSize, maxHeight: size.frameSize)
    }
}

extension ProgressCircleView{
    enum Size{
        case small, medium, large
        
        
        var frameSize: CGFloat?{
            switch self{
            case .small:
                return 50
            case .medium:
                return 90
            case .large:
                return nil
            }
        }
        
        var font: Font{
            switch self{
            case .small:
                return Font.caption.weight(.semibold)
            case .medium, .large:
                return Font.callout.weight(.semibold)
            }
        }
        var lineWidth: CGFloat{
            switch self{
            case .small:
                return 10
            case .medium, .large:
                return 15
            }
        }
    }
}

struct ProgressCircleView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 60){
            ProgressCircleView(progressModel: .init(title: "Day", message: "3 of 7", persentageComplete: 0.43))
                .frame(width: 200, height: 200)
            ProgressCircleView(progressModel: .init(title: "Day", message: "3 of 7", persentageComplete: 0.43), size: .small)
          
        }
        
    }
}
