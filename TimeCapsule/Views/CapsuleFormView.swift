//
//  CapsuleFormView.swift
//  TimeCapsule
//
//  Created by Kuba Rejmann on 27/12/2024.
//

import SwiftUI

struct CapsuleFormView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String
    @State private var unlockDate: Date
    @State private var message: String
    
    let capsule: TimeCapsule?
    
    @State private var showingLockAlert = false
    
    init(capsule: TimeCapsule? = nil) {
        self.capsule = capsule
        
        _title = State(initialValue: capsule?.title ?? "")
        _unlockDate = State(initialValue: capsule?.unlockDate ?? Date().addingTimeInterval(24*3600))
        _message = State(initialValue: capsule?.message ?? "")
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Basic Information") {
                    TextField("Title", text: $title)
                    DatePicker("Unlock at",
                             selection: $unlockDate,
                             in: Date()...,
                             displayedComponents: [.date, .hourAndMinute])
                }
                
                Section("Message") {
                    TextEditor(text: $message)
                        .frame(minHeight: 100)
                }
            }
            .navigationTitle(capsule == nil ? "New Time Capsule" : "Time Capsule")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveTimeCapsule()
                    }
                    .disabled(title.isEmpty)
                }
            }
            
            if capsule != nil && !capsule!.isLocked {
                Button(action: {
                    showingLockAlert = true
                }) {
                    HStack {
                        Image(systemName: "lock.fill")
                        Text("Lock Time Capsule")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding()
            }
        }
        .alert("Lock Time Capsule", isPresented: $showingLockAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Lock", role: .destructive) {
                lockCapsule()
            }
        } message: {
            Text("Are you sure you want to lock this time capsule? You won't be able to modify it until \(unlockDate.formatted(date: .long, time: .shortened))")
        }
    }
    
    private func saveTimeCapsule() {
        if let existingCapsule = capsule {
            existingCapsule.title = title
            existingCapsule.unlockDate = unlockDate
            existingCapsule.message = message
            existingCapsule.updateLastModified()
        } else {
            let newCapsule = TimeCapsule(
                title: title,
                unlockDate: unlockDate,
                message: message
            )
            modelContext.insert(newCapsule)
        }
        dismiss()
    }
    
    private func lockCapsule() {
        guard let existingCapsule = capsule else { return }
        existingCapsule.isLocked = true
        existingCapsule.updateLastModified()
        dismiss()
    }
}

#Preview {
    CapsuleFormView()
        .modelContainer(for: TimeCapsule.self, inMemory: true)
}
