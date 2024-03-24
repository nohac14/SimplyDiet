//
//  Profile.swift
//  HealthDietApp
//
//  Created by Jonas Lazebnik on 3/23/24.
//

import SwiftUI
import UIKit

struct ProfileData: Codable {
    var name: String
    var sex: String
    var age: String
    var feet: String
    var inches: String
    var pounds: String
}

struct TactileButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.75 : 0.85)
    }
}

struct Profile: View {
    @State private var name: String = ""
    @State private var sex: String = "Male"
    @State private var age: String = ""
    @State private var feet: String = ""
    @State private var inches: String = ""
    @State private var pounds: String = ""
    @State private var calculatedBMI: String = ""
    @State private var bmiCategory: String = ""
    
    private let impactFeedback = UIImpactFeedbackGenerator(style: .medium) // Haptic feedback generator

    var body: some View {
        ZStack {
            VStack {
                NavigationView {
                    Form {
                        Section(header: Text("Name")) {
                            TextField("Enter your name", text: $name)
                        }

                        Section(header: Text("Sex")) {
                            Picker(selection: $sex, label: Text("Sex")) {
                                Text("Male").tag("Male")
                                Text("Female").tag("Female")
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }

                        Section(header: Text("Age")) {
                            TextField("Years", text: $age)
                                .keyboardType(.numberPad)
                        }

                        Section(header: Text("Height (ft)")) {
                            HStack {
                                TextField("Feet", text: $feet)
                                    .keyboardType(.numberPad)
                                TextField("Inches", text: $inches)
                                    .keyboardType(.numberPad)
                            }
                        }

                        Section(header: Text("Weight (lbs)")) {
                            TextField("Pounds", text: $pounds)
                                .keyboardType(.numberPad)
                        }

                        Section(header: Text("BMI")) {
                            Text(calculatedBMI)
                            Text(bmiCategory)
                                .foregroundColor(getBMIColor(from: bmiCategory))
                        }
                    }
                    .navigationTitle("Profile")
                    .navigationBarItems(trailing:
                        Button("Save") {
                            saveProfile()
                            impactFeedback.impactOccurred() // Trigger haptic feedback
                        }
                        .buttonStyle(TactileButtonStyle())
                    )
                }
                .onAppear {
                    loadProfile()
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
            // Handle keyboard hide event here (e.g., clear focus on the text field)
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    // Function to handle keyboard hide event
    func keyboardWillHide() {
        // Clear focus on the text field when the keyboard hides
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

    func calculateBMI() {
        guard let weightInPounds = Double(pounds), weightInPounds > 0 else {
            calculatedBMI = ""
            return
        }
        guard let feetValue = Double(feet), feetValue > 0 else {
            calculatedBMI = ""
            return
        }
        guard let inchesValue = Double(inches), inchesValue >= 0 else {
            calculatedBMI = ""
            return
        }

        let weightInKilograms = 0.453592 * weightInPounds
        let heightInMeters = 0.0254 * (feetValue * 12 + inchesValue)
        
        var bmi: Double
            if sex.lowercased() == "male" {
                bmi = weightInKilograms / (heightInMeters * heightInMeters)
            } else {
                bmi = (weightInKilograms * 1.07) / (heightInMeters * heightInMeters)
            }

            if let ageValue = Double(age), ageValue < 18 {
                bmi *= 1.2
            }
            if let ageValue = Double(age), ageValue >= 65 {
                bmi += 1
            }
        
        calculatedBMI = String(format: "%.1f", bmi)
        bmiCategory = getBMICategory(bmi: bmi)
    }

    func saveProfile() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
        calculateBMI()

        let profile = ProfileData(
            name: name,
            sex: sex,
            age: age,
            feet: feet,
            inches: inches,
            pounds: pounds
        )

        if let encoded = try? JSONEncoder().encode(profile) {
            UserDefaults.standard.set(encoded, forKey: "profileData")
        }
    }

    func loadProfile() {
        if let data = UserDefaults.standard.data(forKey: "profileData"),
           let profile = try? JSONDecoder().decode(ProfileData.self, from: data) {
            name = profile.name
            sex = profile.sex
            age = profile.age
            feet = profile.feet
            inches = profile.inches
            pounds = profile.pounds
            calculateBMI()
        }
    }

    func getBMIColor(from bmiCategory: String) -> Color {
        switch bmiCategory {
        case "Normal Weight":
            return .green
        case "Overweight":
            return .yellow
        case "Obese":
            return .red
        case "Underweight":
            return .orange
        default:
            return .black
        }
    }

    func getBMICategory(bmi: Double) -> String {
        if bmi < 18.5 {
            return "Underweight"
        } else if bmi < 25 {
            return "Normal Weight"
        } else if bmi < 30 {
            return "Overweight"
        } else {
            return "Obese"
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
