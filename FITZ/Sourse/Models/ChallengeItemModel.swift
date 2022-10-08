//
//  ChallengeItemModel.swift
//  FITZ
//
//  Created by Bogdan Zykov on 16.09.2022.
//

import Foundation

struct ChallengeItemModel: Identifiable{
    
    private let challenge: Challenge
    
    var id: String{
        challenge.id!
    }
    
    
    init(_ challenge: Challenge, onDelete: @escaping (String) -> Void){
        self.challenge = challenge
        self.onDelete = onDelete
    }
    
    var title: String{
        challenge.exercise.capitalized
    }
    
    private var isComplete: Bool{
        daysFromStart - challenge.lenght >= 0
    }
    
    var progressCircleModel: ProgressCircleModel{
        let dayNumber = daysFromStart + 1
        let title = "Day"
        let message = isComplete ? "Done" : "\(dayNumber) of \(challenge.lenght)"
        let persentageComplete = Double(dayNumber) / Double(challenge.lenght)
        return ProgressCircleModel(title: title, message: message, persentageComplete: persentageComplete)
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
    
    private let onDelete: (String) -> Void
    
    func tappedDelete(){
        if let id = challenge.id{
            onDelete(id)
        }
    }
    
}
