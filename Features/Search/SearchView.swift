import SwiftUI

struct SearchView: View {
    @State private var query: String = ""
    @State private var selectedScope: SearchScope = .global
    @State private var selectedItems = Set<UUID>()
    @State private var editMode: EditMode = .inactive
    @State private var showingSheet = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Picker("Scope", selection: $selectedScope) {
                    ForEach(SearchScope.allCases, id: \.self) { scope in
                        Text(scope.rawValue).tag(scope)
                    }
                }
                .pickerStyle(.segmented)
                .padding()

                List(selection: $selectedItems) {
                    ForEach(filteredItems) { item in
                        SearchResultRow(item: item)
                            .tag(item.id)
                    }
                }
                .listStyle(.plain)
                .searchable(text: $query, prompt: "Search for foods or recipes")
                .environment(\.editMode, $editMode)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Search")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(editMode == .active ? "Done" : "Select") {
                        withAnimation {
                            editMode = (editMode == .active) ? .inactive : .active
                            if editMode == .inactive {
                                selectedItems.removeAll()
                            }
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    if !selectedItems.isEmpty {
                        Button {
                            showingSheet = true
                        } label: {
                            HStack(spacing: 6) {
                                Text("(\(selectedItems.count))")
                                Image(systemName: "slider.horizontal.3")
                            }
                            .fontWeight(.bold)
                        }
                    }
                }
            }
            .sheet(isPresented: $showingSheet) {
                VStack(spacing: 24) {
                    Capsule()
                        .fill(Color.secondary.opacity(0.3))
                        .frame(width: 40, height: 5)
                        .padding(.top, 12)

                    VStack(spacing: 8) {
                        Text("\(selectedItems.count) Items Selected")
                            .font(.headline)
                        Text("Choose an action for your selection")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    VStack(spacing: 12) {
                        ActionRow(title: "Add to Meal Plan", icon: "calendar.badge.plus", color: .blue) {
                            performAction(type: .addToMealPlan)
                        }
                        
                        ActionRow(title: "Add to Collection", icon: "folder.badge.plus", color: .purple) {
                            performAction(type: .addToCollection)
                        }
                        
                        ActionRow(title: "View Calories Info", icon: "flame.fill", color: .orange) {
                            performAction(type: .viewCalories)
                        }
                        
                        Divider().padding(.vertical, 4)
                        
                        ActionRow(title: "Delete Items", icon: "trash", color: .red, isDestructive: true) {
                            performAction(type: .delete)
                        }
                    }
                    .padding(.horizontal)

                    Spacer()
                }
                .presentationDetents([.medium, .large])
                .presentationBackgroundInteraction(.automatic)
                .presentationBackground(.regularMaterial)
                .presentationDragIndicator(.visible)
            }
        }
    }
    
    enum ActionType {
        case addToMealPlan, addToCollection, viewCalories, delete
    }
    
    private func performAction(type: ActionType) {
        let items = filteredItems.filter { selectedItems.contains($0.id) }
        
        switch type {
        case .addToMealPlan:
            print("Adding \(items.count) items to plan...")
        case .addToCollection:
            print("Saving \(items.count) items to favorites...")
        case .viewCalories:
            print("Calculating total calories...")
        case .delete:
            print("Deleting \(items.count) items...")
        }
        
        // Close sheet and reset selection
        showingSheet = false
        withAnimation {
            selectedItems.removeAll()
            editMode = .inactive
        }
    }
    
    var filteredItems: [SearchResult] {
        var allItems: [SearchResult] = []
        switch selectedScope {
        case .global:
            allItems.append(contentsOf: PlannerMockData.foods.map { SearchResult.food($0) })
            allItems.append(contentsOf: PlannerMockData.recipes.map { SearchResult.recipe($0) })
        case .recipes:
            allItems.append(contentsOf: PlannerMockData.recipes.map { SearchResult.recipe($0) })
        case .food:
            allItems.append(contentsOf: PlannerMockData.foods.map { SearchResult.food($0) })
        }
        
        if query.isEmpty { return allItems }
        return allItems.filter { $0.name.localizedCaseInsensitiveContains(query) }
    }
}

struct ActionRow: View {
    let title: String
    let icon: String
    let color: Color
    var isDestructive: Bool = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 15) {
                Image(systemName: icon)
                    .font(.title3)
                    .frame(width: 30)
                
                Text(title)
                    .font(.body)
                    .fontWeight(.medium)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(isDestructive ? Color.red.opacity(0.1) : Color.primary.opacity(0.05))
            .foregroundColor(isDestructive ? .red : .primary)
            .cornerRadius(12)
        }
    }
}

struct SearchResultRow: View {
    let item: SearchResult
    var body: some View {
        HStack {
            if let imageName = item.imageSrc {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipped()
                    .cornerRadius(8)
            }
            VStack(alignment: .leading) {
                Text(item.name).font(.headline)
                if let desc = item.description {
                    Text(desc).font(.subheadline).foregroundColor(.secondary).lineLimit(1)
                }
            }
            Spacer()
            Text(item.type.rawValue)
                .font(.caption)
                .padding(4)
                .background(Color.secondary.opacity(0.1))
                .cornerRadius(4)
        }
        .padding(.vertical, 4)
    }
}

enum SearchScope: String, CaseIterable {
    case global = "Global"
    case recipes = "Recipes"
    case food = "Food"
}

enum SearchResult: Identifiable {
    case food(Food)
    case recipe(Recipe)
    
    var id: UUID {
        switch self {
        case .food(let f): return f.id
        case .recipe(let r): return r.id
        }
    }
    
    var name: String {
        switch self {
        case .food(let f): return f.name
        case .recipe(let r): return r.name
        }
    }
    
    var description: String? {
        switch self {
        case .food(let f): return f.description
        case .recipe(_): return nil
        }
    }
    
    var imageSrc: String? {
        switch self {
        case .food(let f): return f.imageSrc
        case .recipe(let r): return r.imageSrc
        }
    }
    
    var type: SearchScope {
        switch self {
        case .food(_): return .food
        case .recipe(_): return .recipes
        }
    }
}
