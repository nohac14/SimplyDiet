//
//  InputCalories.swift
//  HealthDietApp
//
//  Created by Utkarsh and Karthik on 3/24/24.
//

import SwiftUI

struct InputCalories: View {
    @EnvironmentObject var manager: FoodItemsManager
    @State private var foodName = ""
    @State private var calorieCount = ""

    var body: some View {
        ZStack {
            VStack {
                TextField("Enter food name", text: $foodName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Enter calories", text: $calorieCount)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Add") {
                    if let calorieInt = Int(calorieCount), !foodName.isEmpty {
                        manager.addFoodItem(name: foodName, calorieCount: calorieInt)
                        calorieCount = ""
                        foodName = ""
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                }
                .padding()

                Button("Clear") {
                    manager.clearFoodItems()
                }
                .padding()

                List {
                    ForEach(manager.foodItems) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text("\(item.calorieCount) Calories")
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            // If tapping should re-add the item's calories, consider how you want to reflect this in your total.
                            
                            manager.addFoodItem(name: item.name, calorieCount: item.calorieCount)
                        }
                    }
                    .onDelete(perform: deleteFoodItem)
                }
                .listStyle(PlainListStyle())
                .padding()

                Text("Total Calories: \(manager.tcalorie)")
            }
        }
    }

    // Function to delete food items, called by swipe-to-delete
    private func deleteFoodItem(at offsets: IndexSet) {
        manager.foodItems.remove(atOffsets: offsets)
        manager.saveFoodItems()// Consider calling saveFoodItems() to persist the deletion if it's not automatically handled in your FoodItemsManager.
    }
}

struct InputCalories_Previews: PreviewProvider {
    static var previews: some View {
        InputCalories().environmentObject(FoodItemsManager())
    }
}

