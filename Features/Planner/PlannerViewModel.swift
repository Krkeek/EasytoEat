internal import Combine
import Foundation
import SwiftUI

class PlannerViewModel: ObservableObject {
    @Published var meals: [Meal] = PlannerMockData.meals
    @Published var selectedDate = Date()

    func nutritionInfo(for date: Date) -> NutritionInfo {
        let totalCarbs = 96.5
        let totalFat = 43.0
        let totalProtein = 143.0

        return NutritionInfo(
            id: UUID(),
            day: date,
            caloriesAmount: 1200,
            caloriesTarget: 2000,
            carbsAmount: totalCarbs,
            fatAmount: totalFat,
            proteinAmount: totalProtein,
            carbsTarget: 300,
            fatTarget: 70,
            proteinTarget: 180
        )
    }

    func items(for type: MealType, today: Date) -> [PlannerItem] {
        meals
            .filter { $0.type == type && Calendar.current.isDate($0.date, inSameDayAs: today) }
            .flatMap(\.items)
    }

    func title(for date: Date) -> String {
        let calendar = Calendar.current

        if calendar.isDateInToday(date) {
            return "Today"
        } else if calendar.isDateInTomorrow(date) {
            return "Tomorrow"
        } else if calendar.isDateInYesterday(date) {
            return "Yesterday"
        } else {
            return date.formatted(date: .abbreviated, time: .omitted)
        }
    }
}
