import Foundation

struct RecipeItem: Identifiable {
    let id = UUID()
    let food: Food
    let quantity: Double
    let unit: String
}
