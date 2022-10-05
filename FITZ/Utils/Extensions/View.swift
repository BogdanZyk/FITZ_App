//
//  View.swift
//  Happy Me Meditation
//
//  Created by Богдан Зыков on 17.07.2022.
//


import SwiftUI


extension View{
    
    func getRect() -> CGRect{
        return UIScreen.main.bounds
    }
    
    func allFrame() -> some View{
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    //MARK: Vertical Center
    func vCenter() -> some View{
        self
            .frame(maxHeight: .infinity, alignment: .center)
    }
    //MARK: Vertical Top
    func vTop() -> some View{
        self
            .frame(maxHeight: .infinity, alignment: .top)
    }
    //MARK: Vertical Bottom
    func vBottom() -> some View{
        self
            .frame(maxHeight: .infinity, alignment: .bottom)
    }
    //MARK: Horizontal Center
    func hCenter() -> some View{
        self
            .frame(maxWidth: .infinity, alignment: .center)
    }
    //MARK: Horizontal Leading
    func hLeading() -> some View{
        self
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    //MARK: Horizontal Trailing
    func hTrailing() -> some View{
        self
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    
    // fix new bug in Xcode 14
    ///error Publishing changes from within view updates is not allowed, this will cause undefined behavior.
    func sync<T:Equatable>(_ published:Binding<T>, with binding:Binding<T>)-> some View{
        self
            .onChange(of: published.wrappedValue) { published in
                binding.wrappedValue = published
            }
            .onChange(of: binding.wrappedValue) { binding in
                published.wrappedValue = binding
            }
    }
    
}




