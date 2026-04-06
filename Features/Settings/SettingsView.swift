import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.accentColor)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Ahmad Hijazi")
                                .font(.title3)
                                .fontWeight(.semibold)

                            Text("View and edit profile")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }

                Section(header: Text("Planning")) {
                    NavigationLink {
                        Text("Collections Screen")
                    } label: {
                        Label("Collections", systemImage: "folder.fill")
                    }

                    NavigationLink {
                        Text("Meal Settings Screen")
                    } label: {
                        Label("Meal Settings", systemImage: "fork.knife")
                    }

                    NavigationLink {
                        Text("Meal Layout Screen")
                    } label: {
                        Label("Meal Layout", systemImage: "square.grid.2x2")
                    }

                    NavigationLink {
                        Text("Generator Settings Screen")
                    } label: {
                        Label("Generator Settings", systemImage: "sparkles")
                    }
                }

                Section(header: Text("Health & Goals")) {
                    NavigationLink {
                        Text("Physical Profile Screen")
                    } label: {
                        Label("Physical Profile", systemImage: "person.fill")
                    }

                    NavigationLink {
                        Text("Weight & Goal Screen")
                    } label: {
                        Label("Weight & Goal", systemImage: "scalemass.fill")
                    }

                    NavigationLink {
                        Text("Nutrition Targets Screen")
                    } label: {
                        Label("Nutrition Targets", systemImage: "target")
                    }
                }

                Section(header: Text("Account")) {
                    NavigationLink {
                        Text("Account Info Screen")
                    } label: {
                        Label("Account Info", systemImage: "person.crop.circle.badge.exclamationmark")
                    }

                    Button(role: .destructive) {
                        print("Logging out...")
                    } label: {
                        Label("Logout", systemImage: "arrow.right.circle.fill")
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
