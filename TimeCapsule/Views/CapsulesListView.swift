import SwiftUI
import SwiftData

struct CapsulesListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \TimeCapsule.unlockDate) private var capsules: [TimeCapsule]
    
    private var lockedCapsules: [TimeCapsule] {
        capsules.filter { $0.hasBeenLocked && !$0.canBeUnlocked }
    }
    
    private var unlockedCapsules: [TimeCapsule] {
        capsules.filter { $0.hasBeenLocked && $0.canBeUnlocked }
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if capsules.isEmpty {
                    ContentUnavailableView(
                        "No Time Capsules",
                        systemImage: "clock",
                        description: Text("Tap the plus button to create your first time capsule")
                    )
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            if !unlockedCapsules.isEmpty {
                                Section(header: SectionHeaderView(title: "Unlocked")) {
                                    ForEach(unlockedCapsules) { capsule in
                                        NavigationLink {
                                            UnlockedCapsuleView(capsule: capsule)
                                           
                                        } label: {
                                            CapsuleListItemView(capsule: capsule)
                                        }
                                    }
                                }
                            }
                            
                            if !lockedCapsules.isEmpty {
                                Section(header: SectionHeaderView(title: "Locked")) {
                                    ForEach(lockedCapsules) { capsule in
                                        NavigationLink {
                                            if capsule.canBeUnlocked {
                                                CapsuleFormView(capsule: capsule)
                                            }
                                        } label: {
                                            CapsuleListItemView(capsule: capsule)
                                        }
                                        .disabled(!capsule.canBeUnlocked)
                                    }
                                }
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
            .navigationTitle("My Time Capsules")
            .toolbar {
                ToolbarItem {
                    NavigationLink {
                        CapsuleFormView()
                    } label: {
                        Label("Add Capsule", systemImage: "plus")
                    }
                }
            }
        }
    }
}

struct SectionHeaderView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.top, 8)
    }
}

#Preview {
    CapsulesListView()
        .modelContainer(for: TimeCapsule.self, inMemory: true)
}
