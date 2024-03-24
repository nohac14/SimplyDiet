//
//  FoodItemsManager.swift
//  HealthDietApp
//
//  Created by Utkarsh and Karthik on 3/24/24.
//

import Foundation
import Combine

class FoodItemsManager: ObservableObject {
    @Published var foodItems: [FoodItem] = []
    @Published var exerciseItems: [ExerciseItem] = []

    var tcalorie: Int {
        let totalFoodCalories = foodItems.reduce(0) { $0 + $1.calorieCount }
        let totalExerciseCalories = exerciseItems.reduce(0) { $0 + $1.EcalorieCount }
        return totalFoodCalories - totalExerciseCalories
    }
    
    init() {
        loadFoodItems()
        loadExerciseItems()
    }
    
    func addFoodItem(name: String, calorieCount: Int) {
        let newItem = FoodItem(id: UUID(), name: name, calorieCount: calorieCount)
        self.foodItems.append(newItem)
        saveFoodItems()
    }
    
    func addExercise(name: String, EcalorieCount: Int) {
        let newExercise = ExerciseItem(id: UUID(), name: name, EcalorieCount: EcalorieCount)
        self.exerciseItems.append(newExercise)
        saveExerciseItems()
    }
    
    func clearFoodItems() {
        self.foodItems.removeAll()
        saveFoodItems()
    }
    
    func clearExercises() {
        self.exerciseItems.removeAll()
        saveExerciseItems()
    }
    
     func saveFoodItems() {
            do {
                    let encoded = try JSONEncoder().encode(foodItems)
                    UserDefaults.standard.set(encoded, forKey: "FoodItems")
                    print("Food items saved successfully.")
                } catch {
                    print("Failed to save food items: \(error)")
                }
        }
        
     func loadFoodItems() {
            if let savedItems = UserDefaults.standard.data(forKey: "FoodItems"),
               let decodedItems = try? JSONDecoder().decode([FoodItem].self, from: savedItems) {
                foodItems = decodedItems
            }
        }
    
    func saveExerciseItems() {
            do {
                let encoded = try JSONEncoder().encode(exerciseItems)
                UserDefaults.standard.set(encoded, forKey: "ExerciseItems")
                print("Exercise items saved successfully.")
            } catch {
                print("Failed to save exercise items: \(error)")
            }
        }
    
    func loadExerciseItems() {
            if let savedItems = UserDefaults.standard.data(forKey: "ExerciseItems"),
               let loadedItems = try? JSONDecoder().decode([ExerciseItem].self, from: savedItems) {
                DispatchQueue.main.async {
                    self.exerciseItems = loadedItems
                }
            }
        }
    
    
}
struct FoodItem: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    var calorieCount: Int
}

struct ExerciseItem: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    var EcalorieCount: Int
}

