import Foundation

struct PlannerMockData {

    // MARK: - Foods
    static let foods: [Food] = [
        Food(
            id: UUID(),
            name: "Eggs",
            brand: nil,
            description: "Boiled eggs",
            imageSrc: "eggs",
            nutritions: [
                Nutrition(id: UUID(), carbs: 1, fat: 11, protein: 13, calories: 155, amount: 100, unit: "g", createdAt: Date(), updatedAt: Date())
            ],
            isStandalone: true,
            createdAt: Date(),
            updatedAt: Date()
        ),
        Food(
            id: UUID(),
            name: "Oats",
            brand: "Quaker",
            description: "Rolled oats",
            imageSrc: "oats",
            nutritions: [
                Nutrition(id: UUID(), carbs: 66, fat: 7, protein: 17, calories: 389, amount: 100, unit: "g", createdAt: Date(), updatedAt: Date())
            ],
            isStandalone: true,
            createdAt: Date(),
            updatedAt: Date()
        ),
        Food(
            id: UUID(),
            name: "Chicken Breast",
            brand: nil,
            description: "Grilled chicken breast",
            imageSrc: "chicken",
            nutritions: [
                Nutrition(id: UUID(), carbs: 0, fat: 3.6, protein: 31, calories: 165, amount: 100, unit: "g", createdAt: Date(), updatedAt: Date())
            ],
            isStandalone: true,
            createdAt: Date(),
            updatedAt: Date()
        ),
        Food(
            id: UUID(),
            name: "Rice",
            brand: nil,
            description: "White rice",
            imageSrc: "rice",
            nutritions: [
                Nutrition(id: UUID(), carbs: 28, fat: 0.3, protein: 2.7, calories: 130, amount: 100, unit: "g", createdAt: Date(), updatedAt: Date())
            ],
            isStandalone: true,
            createdAt: Date(),
            updatedAt: Date()
        ),
        Food(
            id: UUID(),
            name: "Banana",
            brand: nil,
            description: "Fresh banana",
            imageSrc: "banana",
            nutritions: [
                Nutrition(id: UUID(), carbs: 23, fat: 0.3, protein: 1.1, calories: 89, amount: 100, unit: "g", createdAt: Date(), updatedAt: Date())
            ],
            isStandalone: true,
            createdAt: Date(),
            updatedAt: Date()
        )
    ]

    // Helper to fetch food by name
    static func food(_ name: String) -> Food {
        foods.first { $0.name == name }!
    }

    // MARK: - Recipes
    static let recipes: [Recipe] = [
        Recipe(
            id: UUID(),
            name: "Protein Oats",
            ingredients: [
                Ingredient(id: UUID(), foodId: food("Oats").id, quantity: 80, unit: "g"),
                Ingredient(id: UUID(), foodId: food("Banana").id, quantity: 1, unit: "piece")
            ],
            imageSrc: "oats",
            createdAt: Date(),
            updatedAt: Date()
        ),
        Recipe(
            id: UUID(),
            name: "Chicken Rice",
            ingredients: [
                Ingredient(id: UUID(), foodId: food("Chicken Breast").id, quantity: 200, unit: "g"),
                Ingredient(id: UUID(), foodId: food("Rice").id, quantity: 150, unit: "g")
            ],
            imageSrc: "chicken_rice",
            createdAt: Date(),
            updatedAt: Date()
        ),
        Recipe(
            id: UUID(),
            name: "Egg Breakfast",
            ingredients: [
                Ingredient(id: UUID(), foodId: food("Eggs").id, quantity: 3, unit: "pieces")
            ],
            imageSrc: "eggs",
            createdAt: Date(),
            updatedAt: Date()
        ),
        Recipe(
            id: UUID(),
            name: "Chicken & Banana Combo",
            ingredients: [
                Ingredient(id: UUID(), foodId: food("Chicken Breast").id, quantity: 150, unit: "g"),
                Ingredient(id: UUID(), foodId: food("Banana").id, quantity: 1, unit: "piece")
            ],
            imageSrc: "chicken",
            createdAt: Date(),
            updatedAt: Date()
        ),
        Recipe(
            id: UUID(),
            name: "Simple Rice Bowl",
            ingredients: [
                Ingredient(id: UUID(), foodId: food("Rice").id, quantity: 200, unit: "g")
            ],
            imageSrc: "rice",
            createdAt: Date(),
            updatedAt: Date()
        )
    ]

    // Helper
    static func recipe(_ name: String) -> Recipe {
        recipes.first { $0.name == name }!
    }

    // MARK: - Meals (8 meals for different types)
    static let meals: [Meal] = [
        Meal(
            id: UUID(),
            type: .breakfast,
            items: [
                .food(food("Eggs")),
                .recipe(recipe("Protein Oats"))
            ],
            date: Date(),
            createdAt: Date(),
            updatedAt: Date(),
        ),
        Meal(
            id: UUID(),
            type: .lunch,
            items: [
                .recipe(recipe("Chicken Rice"))
            ],
            date: Date(),
            createdAt: Date(),
            updatedAt: Date(),
        ),
        Meal(
            id: UUID(),
            type: .dinner,
            items: [
                .recipe(recipe("Chicken & Banana Combo"))
            ],
            date: Date(),
            createdAt: Date(),
            updatedAt: Date(),
        ),
        Meal(
            id: UUID(),
            type: .snack,
            items: [
                .food(food("Banana"))
            ],
            date: Date(),
            createdAt: Date(),
            updatedAt: Date(),
        ),
        Meal(
            id: UUID(),
            type: .breakfast,
            items: [
                .recipe(recipe("Egg Breakfast"))
            ],
            date: Date().addingTimeInterval(86400),
            createdAt: Date(),
            updatedAt: Date(),
        ),
        Meal(
            id: UUID(),
            type: .lunch,
            items: [
                .recipe(recipe("Simple Rice Bowl"))
            ],
            date: Date().addingTimeInterval(86400),
            createdAt: Date(),
            updatedAt: Date(),
        ),
        Meal(
            id: UUID(),
            type: .dinner,
            items: [
                .food(food("Chicken Breast"))
            ],
            date: Date().addingTimeInterval(86400),
            createdAt: Date(),
            updatedAt: Date(),
        ),
        Meal(
            id: UUID(),
            type: .snack,
            items: [
                .food(food("Oats"))
            ],
            date: Date().addingTimeInterval(86400),
            createdAt: Date(),
            updatedAt: Date(),
        )
    ]
}
