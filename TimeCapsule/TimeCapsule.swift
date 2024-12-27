extension TimeCapsule {
    static var mockCapsules: [TimeCapsule] {
        [
            TimeCapsule(
                title: "Birthday Memories 2024",
                creationDate: Date().addingTimeInterval(-7*24*3600),
                unlockDate: Date().addingTimeInterval(365*24*3600),
                textMessage: "My 30th birthday memories"
            ),
            TimeCapsule(
                title: "Letter to Future Self",
                creationDate: Date().addingTimeInterval(-30*24*3600),
                unlockDate: Date().addingTimeInterval(180*24*3600),
                textMessage: "Goals and dreams for 2025"
            ),
            TimeCapsule(
                title: "Wedding Anniversary",
                creationDate: Date().addingTimeInterval(-1*24*3600),
                unlockDate: Date().addingTimeInterval(30*24*3600),
                textMessage: "Our special day"
            )
        ]
    }
} 