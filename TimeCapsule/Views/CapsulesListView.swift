import SwiftUI
import SwiftData

struct CapsulesListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var capsules: [TimeCapsule]
    
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
                            ForEach(capsules) { capsule in
                                NavigationLink {
                                    CapsuleFormView(capsule: capsule)
                                } label: {
                                    CapsuleListItemView(capsule: capsule)
                                }
                                .disabled(capsule.isLocked)
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

#Preview {
    CapsulesListView()
        .modelContainer(for: TimeCapsule.self, inMemory: true)
}
