import Foundation

struct PlannerMockData {

    // MARK: - Foods
    static let egg = Food(name: "Eggs", calories: 155)
    static let oats = Food(name: "Oats", calories: 389)
    static let chicken = Food(name: "Chicken Breast", calories: 165)
    static let rice = Food(name: "Rice", calories: 130)
    static let banana = Food(name: "Banana", calories: 89)

    // MARK: - Recipes
    static let chickenRice = Recipe(
        name: "Chicken Rice",
        items: [
            RecipeItem(food: chicken, quantity: 200, unit: "g"),
            RecipeItem(food: rice, quantity: 150, unit: "g")
        ]
    )

    static let proteinOats = Recipe(
        name: "Protein Oats",
        items: [
            RecipeItem(food: oats, quantity: 80, unit: "g"),
            RecipeItem(food: banana, quantity: 1, unit: "piece")
        ]
    )
    
    static let meals: [Meal] = [
        Meal(
            type: .breakfast,
            items: [
                .food(Food(name: "Eggs", calories: 155)),
                .food(Food(name: "Oats", calories: 389)),
                .recipe(
                    Recipe(
                        name: "Protein Oats",
                        items: []
                    )
                )
            ]
        ),

        Meal(
            type: .lunch,
            items: [
                .recipe(
                    Recipe(
                        name: "Chicken Rice",
                        items: []
                    )
                )
            ]
        ),

        Meal(
            type: .snack,
            items: [
                .food(Food(name: "Banana", calories: 89))
            ]
        )
    ]
}

