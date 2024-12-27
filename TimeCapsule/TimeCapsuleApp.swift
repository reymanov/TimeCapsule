//
//  TimeCapsuleApp.swift
//  TimeCapsule
//
//  Created by Kuba Rejmann on 27/12/2024.
//

import SwiftUI
import SwiftData

@main
struct TimeCapsuleApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            TimeCapsule.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            CapsulesListView()
        }
        .modelContainer(sharedModelContainer)
    }
}
