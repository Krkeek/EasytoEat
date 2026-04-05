import Foundation
struct Meal: Identifiable {
    let id: UUID
    let type: MealType
    var items: [PlannerItem]
    let date: Date
    let createdAt: Date
    let updatedAt: Date
}
