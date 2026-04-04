import SwiftUI

struct PlannerView: View {
    @StateObject private var vm = PlannerViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.meals) { meal in
                    Section(header: Text(meal.type.rawValue)) {
                        ForEach(meal.items) { item in
                            Text(item.displayName)
                        }
                    }
                }
            }
            .navigationTitle("Planner")
        }
    }
}
