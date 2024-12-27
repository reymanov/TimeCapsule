//
//  CountdownTimerView.swift
//  TimeCapsule
//
//  Created by Kuba Rejmann on 28/12/2024.
//

import SwiftUI

struct CountdownTimerView: View {
    let targetDate: Date
    let countdownActive: Bool
    
    @State private var timeRemaining: TimeInterval = 0
    @State private var isTimerRunning = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Text(formatTimeRemaining(timeRemaining))
            .font(.system(.caption, design: .monospaced))
            .foregroundColor(getTimerColor())
            .onAppear {
                if countdownActive {
                    updateTimeRemaining()
                    isTimerRunning = timeRemaining > 0
                }
            }
            .onReceive(timer) { _ in
                if countdownActive && isTimerRunning {
                    updateTimeRemaining()
                    if timeRemaining <= 0 {
                        isTimerRunning = false
                    }
                }
            }
    }
    
    private func updateTimeRemaining() {
        timeRemaining = targetDate.timeIntervalSinceNow
    }
    
    private func formatTimeRemaining(_ timeInterval: TimeInterval) -> String {
        if timeInterval <= 0 {
            return "00:00:00:00"
        }
        
        let days = Int(timeInterval / (24 * 3600))
        let hours = Int((timeInterval.truncatingRemainder(dividingBy: 24 * 3600)) / 3600)
        let minutes = Int((timeInterval.truncatingRemainder(dividingBy: 3600)) / 60)
        let seconds = Int(timeInterval.truncatingRemainder(dividingBy: 60))
        
        return String(format: "%02d:%02d:%02d:%02d", days, hours, minutes, seconds)
    }
    
    private func getTimerColor() -> Color {
        if !countdownActive {
            return .primary
        }
        return timeRemaining > 0 ? .orange : .green
    }
}

#Preview {
    VStack(spacing: 20) {
        CountdownTimerView(targetDate: Date().addingTimeInterval(3600 * 25), countdownActive: false) // 25 hours
        CountdownTimerView(targetDate: Date().addingTimeInterval(3600), countdownActive: true) // 1 hour
        CountdownTimerView(targetDate: Date().addingTimeInterval(60), countdownActive: true) // 1 minute
        CountdownTimerView(targetDate: Date(), countdownActive: true) // Now (expired)
    }
}
