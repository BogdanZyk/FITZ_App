//
//  Image.swift
//  Happy Me Meditation
//
//  Created by Богдан Зыков on 17.07.2022.
//



import SwiftUI


extension Image{
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, height: geo.size.height)
            .clipped()
        }
    }
}
