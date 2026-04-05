import SwiftUI

struct PlannerView: View {
    @StateObject private var vm = PlannerViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Button(action: {
                        vm.selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: vm.selectedDate)!
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                    }
                    
                    Spacer()
                    
                    Text(vm.title(for: vm.selectedDate))
                        .font(.headline)
                    
                    Spacer()
                    
                    Button(action: {
                        vm.selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: vm.selectedDate)!
                    }) {
                        Image(systemName: "chevron.right")
                            .font(.title2)
                    }
                }
                .padding(.horizontal)
                
                List {
                    let todayNutrition = vm.nutritionInfo(for: vm.selectedDate)
                    let eaten = todayNutrition.CaloriesAmount
                    let target = todayNutrition.CaloriesTarget
                    let remaining = max(target - eaten, 0)
                    
                    VStack {
                        ZStack {
                            Gauge(value: eaten, in: 0...target) {
                                Image(systemName: "flame.fill")
                                    .foregroundStyle(.red)
                            } currentValueLabel: {
                                Text("\(Int(eaten)) kcal")
                                    .font(.title2)
                                    .bold()
                            }
                            .gaugeStyle(.accessoryCircular)
                            .scaleEffect(2)
                            .padding(.top, 30)
                            .padding(.bottom, 20)
                            
                            HStack {
                                VStack {
                                    Text("Target")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    Text("\(Int(target))")
                                        .foregroundColor(.green)
                                        .font(.headline)
                                }
                                .frame(width: 200)
                                
                                VStack {
                                    Text("Remaining")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    Text("\(Int(remaining))")
                                        .foregroundColor(.red)
                                        .font(.headline)
                                }
                                .frame(width: 200)
                            }
                        }
                        
                        HStack {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Carbs")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    Text("\(Int(todayNutrition.CarbsAmount))g")
                                        .font(.caption2)
                                        .bold()
                                }
                                Gauge(value: todayNutrition.CarbsAmount, in: 0...todayNutrition.CarbsTarget) {}
                                    .gaugeStyle(.accessoryLinear)
                                    .tint(.blue)
                                    .frame(maxWidth: 100)
                            }
                            
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Fat")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    Text("\(Int(todayNutrition.FatAmount))g")
                                        .font(.caption2)
                                        .bold()
                                }
                                Gauge(value: todayNutrition.FatAmount, in: 0...todayNutrition.FatTarget) {}
                                    .gaugeStyle(.accessoryLinear)
                                    .tint(.orange)
                                    .frame(maxWidth: 100)
                            }
                            
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Protein")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    Text("\(Int(todayNutrition.ProteinAmount))g")
                                        .font(.caption2)
                                        .bold()
                                }
                                Gauge(value: todayNutrition.ProteinAmount, in: 0...todayNutrition.ProteinTarget) {}
                                    .gaugeStyle(.accessoryLinear)
                                    .tint(.green)
                                    .frame(maxWidth: 100)
                            }
                        }
                        .padding(.vertical, 10)
                    }
                    
                    ForEach(MealType.allCases) { type in
                        let items = vm.items(for: type, today: vm.selectedDate)
                        
                        if !items.isEmpty {
                            Section(header: Text(type.rawValue)) {
                                ForEach(items, id: \.id) { item in
                                    HStack {
                                        if let imageSrc = item.imageSrc {
                                            Image(imageSrc)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 50, height: 50)
                                                .clipped()
                                                .cornerRadius(8)
                                        }
                                        
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text(item.displayName)
                                                .font(.headline)
                                            
                                            Text(item.subtitle)
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                        }
                                        
                                        Spacer()
                                        
                                        Menu {
                                            Button(role: .destructive) {
                                                // delete
                                            } label: {
                                                Label("Delete", systemImage: "trash")
                                            }
                                            
                                            Button {
                                                // edit
                                            } label: {
                                                Label("Edit", systemImage: "pencil")
                                            }
                                        } label: {
                                            Image(systemName: "ellipsis")
                                                .rotationEffect(.degrees(90))
                                                .font(.system(size: 18, weight: .medium))
                                                .foregroundColor(.secondary)
                                                .frame(width: 30, height: 30)
                                        }
                                        .menuStyle(.borderlessButton)
                                    }
                                    .padding(.vertical, 4)
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("EasytoEat")
                        .font(.headline)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button {
                            print("Plus tapped")
                        } label: {
                            Image(systemName: "plus")
                                .font(.title2)
                        }	

                        Menu {
                            Button {
                                     print("Regenerate Day tapped")
                                 } label: {
                                     Label("Regenerate Day", systemImage: "arrow.clockwise")
                                 }

                                 Button {
                                     print("Edit Meal Layout tapped")
                                 } label: {
                                     Label("Edit Meal Layout", systemImage: "square.and.pencil")
                                 }

                                 Button(role: .destructive) {
                                     print("Clear Day tapped")
                                 } label: {
                                     Label("Clear Day", systemImage: "trash")
                                 }
                        } label: {
                            Image(systemName: "ellipsis")
                                .font(.title2)
                        }
                    }
                }
            }
        }
    }
}
