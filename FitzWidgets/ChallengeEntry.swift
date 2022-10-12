//
//  ChallengeEntry.swift
//  FitzWidgetsExtension
//
//  Created by Bogdan Zykov on 12.10.2022.
//

import WidgetKit


struct ChallengeEntry: TimelineEntry {
    let date: Date
    let challenge: [ChallengeItemModel]
    
    static func mocksChallenge() -> ChallengeEntry{
        return ChallengeEntry(date: Date(), challenge: [
            ChallengeItemModel(Challenge(exercise: "Pulups", startAmount: 5, increase: 3, lenght: 7, userId: "1", startDate: Date(), activities: []), onDelete: nil, onToggleComplete: nil),
            ChallengeItemModel(Challenge(exercise: "Pushups", startAmount: 1, increase: 2, lenght: 4, userId: "2", startDate: Date(), activities: []), onDelete: nil, onToggleComplete: nil),
            ChallengeItemModel(Challenge(exercise: "Situps", startAmount: 2, increase: 2, lenght: 5, userId: "3", startDate: Date(), activities: []), onDelete: nil, onToggleComplete: nil), 
        
        ])
        
    }
}
