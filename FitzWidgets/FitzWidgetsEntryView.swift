//
//  FitzWidgetsEntryView.swift
//  FitzWidgetsExtension
//
//  Created by Bogdan Zykov on 12.10.2022.
//
import SwiftUI
import WidgetKit

struct FitzWidgetsEntryView : View {
    @Environment(\.widgetFamily) var family
    var entry: Provider.Entry

    var body: some View {
        VStack(spacing: 0){
            
                switch family {
                case .systemSmall:
                    smallWidgetView
                case .systemMedium:
                    mediumWidgetView
                default:
                    Text(entry.challenge.first?.title ?? "none")
                }
            
        }
        .padding()
        .allFrame()
        .background(Material.thickMaterial)
    }
}

extension FitzWidgetsEntryView{
    
    private var smallWidgetView: some View{
        Group{
            if let item = entry.challenge.first{
                progressViewComponent(item)
                .hCenter()
            }else{
                Text("You don't have any added challenges")
            }
        }
    }
    
    
    private func progressViewComponent(_ item: ChallengeItemModel) -> some View{
        VStack(spacing: 0) {
            Spacer()
            ProgressCircleView(progressModel: item.progressCircleModel, size: .small)
            Spacer()
            HStack{
                Text(item.toadyRepTitle)
                    .lineLimit(1)
                    .font(.subheadline.weight(.medium))
                if item.isDayComplete{
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.circleTrack)
                }
            }
        }
    }
    
    private var mediumWidgetView: some View{
        HStack{
            ForEach(entry.challenge.prefix(3), id: \.id) { item in
                progressViewComponent(item)
                    .hCenter()
            }
        }
    }
    
}


struct FitzWidgets_Previews: PreviewProvider {
    static var previews: some View {
        FitzWidgetsEntryView(entry: ChallengeEntry.mocksChallenge())
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
