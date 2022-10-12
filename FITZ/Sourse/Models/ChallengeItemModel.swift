//
//  ChallengeItemModel.swift
//  FITZ
//
//  Created by Bogdan Zykov on 16.09.2022.
//

import Foundation

struct ChallengeItemModel: Identifiable{
    
    private let challenge: Challenge
    private let onDelete: (String) -> Void
    private let onToggleComplete: (String, [Activity]) -> Void
    
    let todayTitle = "Today"
    
    
    var id: String{
        challenge.id!
    }
    
    
    init(_ challenge: Challenge,
         onDelete: @escaping (String) -> Void,
         onToggleComplete: @escaping (String, [Activity]) -> Void)
    {
        
        self.challenge = challenge
        self.onDelete = onDelete
        self.onToggleComplete =  onToggleComplete
    }
    
    var title: String{
        challenge.exercise.capitalized
    }
    
    var isComplete: Bool{
        daysFromStart - challenge.lenght >= 0
    }
    
    var challengeLenght: Int{
        challenge.lenght
    }
    
    var countExerciseCompleted: Int{
        challenge.activities.filter({$0.isComplete}).count
    }
    
    var progressCircleModel: ProgressCircleModel{
        let dayNumber = daysFromStart + 1
        let title = "Day"
        let message = isComplete ? "Done" : "\(dayNumber) of \(challengeLenght)"
        let persentageComplete = Double(dayNumber) / Double(challengeLenght)
        return ProgressCircleModel(title: title, message: message, persentageComplete: persentageComplete)
    }
    
    private var daysFromStart: Int{
        let startDate = Calendar.current.startOfDay(for: challenge.startDate)
        let toDate = Calendar.current.startOfDay(for: Date())
        guard let daysFromStart = Calendar.current.dateComponents([.day], from: startDate, to: toDate).day else {return 0}
        return abs(daysFromStart)
    }
    
    
    var dayilyIncreaseText: String{
        "+\(challenge.increase) daily"
    }
    


    func send(_ action: Action){
        guard let id = challenge.id else {return}
        switch action{
        case .delete:
            onDelete(id)
        case .toggleComplete:
            let today = Calendar.current.startOfDay(for: Date())
            let activities = challenge.activities.map { activity -> Activity in
                if today == activity.date{
                    return .init(date: today, isComplete: !activity.isComplete)
                }else{
                    return activity
                }
            }
            onToggleComplete(id, activities)
        }
    }

    
}


extension ChallengeItemModel{
    
    var shouldShowTodayView: Bool{
        !isComplete
    }
        
    var toadyRepTitle: String{
        let repNumber = challenge.startAmount + (daysFromStart * challenge.increase)
        let exercise: String
        if repNumber == 1{
            var chllangeExercise = challenge.exercise
            chllangeExercise.removeLast()
            exercise = chllangeExercise
        }else{
            exercise = challenge.exercise
        }
        return "\(repNumber) " + exercise
    }
}


extension ChallengeItemModel{
    
    var isDayComplete: Bool{
        let today = Calendar.current.startOfDay(for: Date())
        return challenge.activities.first(where: {$0.date == today})?.isComplete == true
    }
    
    enum Action{
        case delete
        case toggleComplete
    }
}
