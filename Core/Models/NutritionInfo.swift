import Foundation

struct NutritionInfo: Identifiable {
    let id: UUID
    let day: Date
    let caloriesAmount: Double
    let caloriesTarget: Double
    let carbsAmount: Double
    let fatAmount: Double
    let proteinAmount: Double
    let carbsTarget: Double
    let fatTarget: Double
    let proteinTarget: Double
}
