import Foundation

struct Nutrition: Identifiable {
    let id: UUID
    let carbs: Double
    let fat: Double
    let protein: Double
    let calories: Double
    let amount: Double
    let unit: String
    let createdAt: Date
    let updatedAt: Date
}
