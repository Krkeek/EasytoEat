import Foundation

enum PlannerItem: Identifiable {
    case food(Food)
    case recipe(Recipe)

    var id: UUID {
        switch self {
            case let .food(food): food.id
            case let .recipe(recipe): recipe.id
        }
    }

    var displayName: String {
        switch self {
            case let .food(food): food.name
            case let .recipe(recipe): recipe.name
        }
    }

    var imageSrc: String? {
        switch self {
            case let .food(food): food.imageSrc
            case let .recipe(recipe): recipe.imageSrc
        }
    }

    var subtitle: String {
        switch self {
            case let .food(food):
                if let nutrition = food.nutritions.first {
                    return "\(Int(nutrition.amount))\(nutrition.unit) · \(Int(nutrition.calories)) kcal"
                } else {
                    return ""
                }

            case let .recipe(recipe):
                let totalCalories = recipe.ingredients.reduce(0.0) { sum, _ in
                    sum
                }

                return "\(Int(totalCalories)) kcal"
        }
    }
}
