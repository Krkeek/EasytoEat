import Foundation

struct NutritionInfo: Identifiable {
    let id: UUID
    let day: Date
    let CaloriesAmount: Double
    let CaloriesTarget: Double
    let CarbsAmount: Double
    let FatAmount: Double
    let ProteinAmount: Double
    let CarbsTarget: Double
    let FatTarget: Double
    let ProteinTarget: Double
}
