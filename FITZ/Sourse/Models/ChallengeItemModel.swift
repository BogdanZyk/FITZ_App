//
//  ChallengeItemModel.swift
//  FITZ
//
//  Created by Bogdan Zykov on 16.09.2022.
//

import Foundation

struct ChallengeItemModel: Hashable{
    
   private let challenge: Challenge
    
    
    init(_ challenge: Challenge){
        self.challenge = challenge
    }
    
    var title: String{
        challenge.exercise.capitalized
    }
    
    private var isComplete: Bool{
        daysFromStart - challenge.lenght >= 0
    }
    
    private var daysFromStart: Int{
        let startDate = Calendar.current.startOfDay(for: challenge.startDate)
        let toDate = Calendar.current.startOfDay(for: Date())
        guard let daysFromStart = Calendar.current.dateComponents([.day], from: startDate, to: toDate).day else {return 0}
        return abs(daysFromStart)
    }
    
    var statusText: String{
        guard !isComplete else { return "Done" }
        let dayNumber = daysFromStart + 1
        return "Day \(dayNumber) of \(challenge.lenght)"
    }
    
    var dayilyIncreaseText: String{
        "+\(challenge.increase) daily"
    }
    
    
}
