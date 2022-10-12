//
//  FitzWidgets.swift
//  FitzWidgets
//
//  Created by Bogdan Zykov on 12.10.2022.
//

import WidgetKit
import SwiftUI


@main
struct FitzWidgets: Widget {
    let kind: String = "FitzWidgets"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            FitzWidgetsEntryView(entry: entry)
        }
        .configurationDisplayName("My Fitz Widget")
        .description("Keep track of your challenge progress an widget.")
        .supportedFamilies([.systemMedium, .systemSmall])
    }
}




