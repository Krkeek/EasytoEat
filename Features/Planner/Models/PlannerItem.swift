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
    
    var imageSrc: String? {
        switch self {
        case .food(let food): return food.imageSrc
        case .recipe(let recipe): return recipe.imageSrc
        }
    }
    
    var subtitle: String {
        switch self {
        case .food(let food):
            if let nutrition = food.nutritions.first {
                return "\(Int(nutrition.amount))\(nutrition.unit) · \(Int(nutrition.calories)) kcal"
            } else {
                return ""
            }
            
        case .recipe(let recipe):
            let totalCalories = recipe.ingredients.reduce(0.0) { sum, ingredient in
                return sum
            }
            
            return "\(Int(totalCalories)) kcal"
        }
    }
}
