import Foundation
import SwiftUI
internal import Combine

class PlannerViewModel: ObservableObject {
    @Published var meals: [Meal] = PlannerMockData.meals
    @Published public var selectedDate = Date()
    
    
    func nutritionInfo(for date: Date) -> NutritionInfo {

        let totalCarbs = 100.0
        let totalFat = 50.0
        let totalProtein = 80.0
        
        return NutritionInfo(
            id: UUID(),
            day: date,
            CaloriesAmount: 1200,
            CaloriesTarget: 2000,
            CarbsAmount: totalCarbs,
            FatAmount: totalFat,
            ProteinAmount: totalProtein,
            CarbsTarget: 300,
            FatTarget: 70,
            ProteinTarget: 120
        )
    }
    

    func items(for type: MealType, today: Date) -> [PlannerItem] {
        meals
            .filter { $0.type == type && Calendar.current.isDate($0.date, inSameDayAs: today) }
            .flatMap { $0.items }
    }
    
    
    func title(for date: Date) -> String {
        if Calendar.current.isDateInToday(date) {
            return "Today"
        } else {
            return date.formatted(date: .abbreviated, time: .omitted)
        }
    }
    
}
