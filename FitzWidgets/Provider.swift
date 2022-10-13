//
//  Provider.swift
//  FitzWidgetsExtension
//
//  Created by Bogdan Zykov on 12.10.2022.
//

import WidgetKit
import FirebaseFirestoreSwift
import Firebase
import FirebaseAuth

struct Provider: TimelineProvider {
    

    
    private let db = Firestore.firestore()
    var currentUser: User? = Auth.auth().currentUser
    
    
    func placeholder(in context: Context) -> ChallengeEntry {
        ChallengeEntry.mocksChallenge()
    }

    func getSnapshot(in context: Context, completion: @escaping (ChallengeEntry) -> ()) {
        let entry = ChallengeEntry.mocksChallenge()
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<ChallengeEntry>) -> ()) {
        
        fetchChallenges { challengeItemModels in
            
            let currentDate = Date()
            var entry = ChallengeEntry.mocksChallenge()
            if let challenge = challengeItemModels {
                entry = ChallengeEntry(date: currentDate, challenge: challenge)
            }
            let refreshDate = Calendar.current.date(byAdding: .minute, value: 60, to: currentDate)!
            let timeLine = Timeline(entries: [entry], policy: .after(refreshDate))
            completion(timeLine)
        }
    }
    
    
    private func fetchChallenges(completion: @escaping ([ChallengeItemModel]?) -> Void){
        guard let userId = currentUser?.uid else {return}
        db.collection("challenges")
            .whereField("userId", isEqualTo: userId).order(by: "startDate", descending: true)
            .addSnapshotListener { documentSnapshot, error in
                if let error = error{
                    print(error.localizedDescription)
                }
                do{
                    let challenges = try documentSnapshot?.documents.compactMap{
                        try $0.data(as: Challenge.self)
                    }
                    let items = challenges?.compactMap({ challenge -> ChallengeItemModel in
                            .init(challenge, onDelete: nil, onToggleComplete: nil)
                    })
                    completion(items)
                }catch{
                    print("Failed to decode user data \(error.localizedDescription)")
                }
            }
    }
}
