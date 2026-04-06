import Foundation

struct Recipe {
    let id: UUID
    let name: String
    let ingredients: [Ingredient]
    let imageSrc: String?
    let createdAt: Date
    let updatedAt: Date
}
