//
//  CapsuleListItemView.swift
//  TimeCapsule
//
//  Created by Kuba Rejmann on 27/12/2024.
//

import SwiftUI

struct CapsuleListItemView: View {
    let capsule: TimeCapsule
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .topTrailing) {
                Text(capsule.title)
                    .font(.headline)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity)
                
                Image(systemName: capsule.hasBeenLocked && !capsule.canBeUnlocked ? "lock.fill" : "lock.open.fill")
                    .padding(4)
            }
            
            CountdownTimerView(targetDate: capsule.unlockDate, countdownActive: capsule.hasBeenLocked)
                .padding(.vertical, 8)
                .frame(maxWidth: 120)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.ultraThinMaterial)
                        .shadow(radius: 2)
                )
            HStack {
                Text("Opens \(capsule.unlockDate, format: .dateTime.day().month().year()) at \(capsule.unlockDate, format: .dateTime.hour().minute())")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
                .shadow(radius: 2)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .strokeBorder(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.6),
                                    Color.gray.opacity(0.4),
                                    Color.white.opacity(0.6)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 2
                        )
                )
        )
        .padding(.horizontal)
        .foregroundColor(.primary)
    }
}

#Preview {
    CapsuleListItemView(capsule: TimeCapsule.mockCapsules[0])
}
