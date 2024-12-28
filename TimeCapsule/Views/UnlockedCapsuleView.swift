//
//  UnlockedCapsuleView.swift
//  TimeCapsule
//
//  Created by Kuba Rejmann on 28/12/2024.
//

import SwiftUI

struct UnlockedCapsuleView: View {
    let capsule: TimeCapsule
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text(capsule.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                VStack(spacing: 12) {
                    timeInfoRow(label: "Created on", date: capsule.creationDate)
                    timeInfoRow(label: "Unlocked on", date: capsule.unlockDate)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.ultraThinMaterial)
                )
            
                if let message = capsule.message, !message.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Message")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        Text(message)
                            .font(.body)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.ultraThinMaterial)
                    )
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func timeInfoRow(label: String, date: Date) -> some View {
        HStack {
            Text(label)
                .foregroundColor(.secondary)
            Spacer()
            Text(date.formatted(date: .long, time: .shortened))
                .fontWeight(.medium)
        }
    }
}

#Preview {
    NavigationStack {
        UnlockedCapsuleView(capsule: TimeCapsule.mockCapsules[0])
    }
}
