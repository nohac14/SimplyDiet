//Utkarsh and Jonas and 
import SwiftUI

struct Home: View {
    @EnvironmentObject var manager: FoodItemsManager
    @Environment(\.colorScheme) var colorScheme // Correctly capture the current color scheme

    var body: some View {
        NavigationView {
            GroupBox {
                VStack(spacing: 20) { // Adjust spacing as needed
                    // Total Net Calories
                    HStack {
                        Text("\(manager.tcalorie)")
                            .font(.system(size: 48, weight: .bold)) // Large, bold font for the main calorie count
                        Text("cal")
                            .font(.subheadline)
                            .foregroundColor(.secondary) // Smaller, secondary color for "cal"
                    }
                    .foregroundColor(.primary) // Adapts to color scheme
                    
                    // Calories Consumed
                    HStack {
                        Text("\(manager.foodItems.reduce(0) { $0 + $1.calorieCount })")
                            .font(.title)
                        Text("cal consumed")
                            .font(.footnote)
                            .foregroundColor(.red) // Make "cal consumed" red
                    }
                    
                    // Calories Burned
                    HStack {
                        Text("\(manager.exerciseItems.reduce(0) { $0 + $1.EcalorieCount })")
                            .font(.title)
                        Text("cal burned")
                            .font(.footnote)
                            .foregroundColor(.green) // Make "cal burned" green
                    }
                    
                    Spacer().frame(height: 40) // Adjust spacing as needed
                    
                    // Manage Food Button
                    NavigationLink(destination: InputCalories()) {
                        Text("Manage Food")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                    
                    // Manage Exercise Button
                    NavigationLink(destination: Exercise()) {
                        Text("Manage Exercise")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                }
                .padding() // Padding for the VStack
                .navigationBarTitle("Home", displayMode: .large)
            }
            .background(colorScheme == .light ? Color.white : Color.black)
            .groupBoxStyle(DefaultGroupBoxStyle()) // Use the default group box style or customize as needed
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home().environmentObject(FoodItemsManager())
    }
}

