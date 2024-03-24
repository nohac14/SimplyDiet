//
//  Exercise.swift
//  HealthDietApp
//
//  Created by Utkarsh Sharma on 3/24/24.
//

import SwiftUI

struct Exercise: View {
    @EnvironmentObject var manager: FoodItemsManager
    @State private var exerciseName = ""
    @State private var exerciseCalorieCount = ""

    var body: some View {
        ZStack {
            VStack {
                TextField("Enter exercise name", text: $exerciseName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Enter calories burned", text: $exerciseCalorieCount)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Add") {
                    if let calorieInt = Int(exerciseCalorieCount), !exerciseName.isEmpty {
                        manager.addExercise(name: exerciseName, EcalorieCount: calorieInt)
                        exerciseCalorieCount = ""
                        exerciseName = ""
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                }
                .padding()

                Button("Clear Exercises") {
                    manager.clearExercises()
                }
                .padding()

                List {
                    ForEach(manager.exerciseItems) { exercise in
                        HStack {
                            Text(exercise.name)
                            Spacer()
                            Text("\(exercise.EcalorieCount) Calories Burned")
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            manager.addExercise(name: exercise.name, EcalorieCount: exercise.EcalorieCount)
                        }
                    }
                    .onDelete(perform: deleteExerciseItem) // Make sure this is uncommented and correctly placed
                }
                .listStyle(PlainListStyle())
                .padding()
                
                Text("Net Calories: \(manager.tcalorie)")
            }
        }
        .onAppear {
                    manager.loadExerciseItems()  // Refresh or reload exercise items
                }
    }

    private func deleteExerciseItem(at offsets: IndexSet) {
        manager.exerciseItems.remove(atOffsets: offsets)
        manager.saveExerciseItems()
        // Consider calling a save method here if your FoodItemsManager does not automatically handle persistence when the list changes.
    }
}

struct Exercise_Previews: PreviewProvider {
    static var previews: some View {
        Exercise().environmentObject(FoodItemsManager())
    }
}
