//
//  testView.swift
//  FITZ
//
//  Created by Bogdan Zykov on 05.10.2022.
//

import SwiftUI

@available(iOS 16.0, *)
struct testView: View {
    
    var body: some View {
        let qragient = Gradient(colors: [.green, .yellow, .orange, .red])
        Gauge(value: 0.4) {
            Text("50")
        }
        .gaugeStyle(.accessoryCircular)
        .tint(qragient)
        .padding()
    }
}


struct testView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 16.0, *) {
            testView()
        } else {
            // Fallback on earlier versions
        }
    }
}

    
    

