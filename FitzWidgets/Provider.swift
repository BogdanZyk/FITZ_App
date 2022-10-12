//
//  Provider.swift
//  FitzWidgetsExtension
//
//  Created by Bogdan Zykov on 12.10.2022.
//

import WidgetKit


struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> ChallengeEntry {
        ChallengeEntry.mocksChallenge()
    }

    func getSnapshot(in context: Context, completion: @escaping (ChallengeEntry) -> ()) {
        let entry = ChallengeEntry.mocksChallenge()
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<ChallengeEntry>) -> ()) {
        var entries: [ChallengeEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = ChallengeEntry.mocksChallenge()
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
