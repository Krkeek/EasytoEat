import Foundation

enum PlannerItem: Identifiable {
    case food(Food)
    case recipe(Recipe)

    var id: UUID {
        switch self {
        case .food(let food): return food.id
        case .recipe(let recipe): return recipe.id
        }
    }

    var displayName: String {
        switch self {
        case .food(let food): return food.name
        case .recipe(let recipe): return recipe.name
        }
    }
}
