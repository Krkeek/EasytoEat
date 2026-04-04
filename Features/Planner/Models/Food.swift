import Foundation

struct Food: Identifiable {
    let id = UUID()
    let name: String
    let calories: Double?
}
