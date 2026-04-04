import Foundation
internal import Combine

class PlannerViewModel: ObservableObject {
    @Published var meals: [Meal] = PlannerMockData.meals

    func meal(for type: MealType) -> Meal? {
        meals.first { $0.type == type }
    }
}
