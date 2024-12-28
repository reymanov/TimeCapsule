//
//  Capsule.swift
//  TimeCapsule
//
//  Created by Kuba Rejmann on 27/12/2024.
//

import Foundation
import SwiftData

@Model
final class TimeCapsule {
    var title: String
    var creationDate: Date
    var unlockDate: Date
    @Attribute(originalName: "isLocked") var hasBeenLocked: Bool
    
    var message: String?
    
    var lastModifiedDate: Date
    
    init(
        title: String,
        creationDate: Date = Date(),
        unlockDate: Date,
        message: String? = nil
    ) {
        self.title = title
        self.creationDate = creationDate
        self.unlockDate = unlockDate
        self.message = message
        self.hasBeenLocked = false
        self.lastModifiedDate = creationDate
    }
    
    var canBeUnlocked: Bool {
        return Date() >= unlockDate
    }
    
    func updateLastModified() {
        self.lastModifiedDate = Date()
    }
}

extension TimeCapsule {
    static var mockCapsules: [TimeCapsule] {
        [
            TimeCapsule(
                title: "Birthday Memories 2024",
                creationDate: Date().addingTimeInterval(-7*24*3600),
                unlockDate: Date().addingTimeInterval(365*24*3600),
                message: "My 30th birthday memories"
            ),
            TimeCapsule(
                title: "Letter to Future Self",
                creationDate: Date().addingTimeInterval(-30*24*3600),
                unlockDate: Date().addingTimeInterval(180*24*3600),
                message: "Goals and dreams for 2025"
            ),
            TimeCapsule(
                title: "Wedding Anniversary",
                creationDate: Date().addingTimeInterval(-1*24*3600),
                unlockDate: Date().addingTimeInterval(30*24*3600),
                message: "Our special day"
            )
        ]
    }
}
