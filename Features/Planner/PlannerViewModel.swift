import Foundation
import SwiftUI
internal import Combine

class PlannerViewModel: ObservableObject {
    @Published var meals: [Meal] = PlannerMockData.meals
    @Published public var selectedDate = Date()
    

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
