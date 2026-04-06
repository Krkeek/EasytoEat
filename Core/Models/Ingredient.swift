import Foundation
struct Ingredient: Identifiable {
    let id: UUID
    let foodId: UUID
    let quantity: Double
    let unit: String
}
