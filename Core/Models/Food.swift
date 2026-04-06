import Foundation

struct Food: Identifiable {
    let id : UUID
    let name: String
    let brand: String?
    let description: String?
    let imageSrc: String?
    let nutritions: [Nutrition]
    let isStandalone: Bool
    let createdAt: Date
    let updatedAt: Date
}
