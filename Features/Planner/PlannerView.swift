import SwiftUI

struct PlannerView: View {
    @StateObject private var vm = PlannerViewModel()
    
    var body: some View {
        
        VStack {
            Spacer()
            Spacer()
            Spacer()
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
            .navigationTitle(vm.title(for: Date()))
            .gesture(
                DragGesture()
                    .onEnded { value in
                        if value.translation.width < -50 {
                            vm.selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: vm.selectedDate)!
                        } else if value.translation.width > 50 {
                            vm.selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: vm.selectedDate)!
                        }
                    }
            )
        }
    }
}
