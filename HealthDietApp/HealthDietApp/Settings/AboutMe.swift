//
//  AboutMe.swift
//  HealthDietApp
//
//  Created by J L on 3/24/24.
//

import SwiftUI

struct AboutMeView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Welcome to SimplyDiet, your personalized calorie counter and food diary app! We're here to help you achieve your health and fitness goals by making it easier to track your daily food intake and manage your calorie consumption.\n")
                    .font(.body)
                
                Text("Our Mission")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("\nAt SimplyDiet we believe that maintaining a healthy lifestyle should be simple and enjoyable. Our mission is to empower you to make informed decisions about your diet and nutrition, so you can live a happier and healthier life.\n\n")
                    .font(.body)
                
                Text("Meet the Team")
                    .font(.title)
                    .fontWeight(.bold)
                
                VStack(alignment: .leading, spacing: 10) {
                    TeamMemberView(name: "\nArjun A.", role: "Co-Founder & CEO", bio: "As the founder of SimplyDiet, I'm passionate about health and wellness. With a background in nutrition and fitness, I created this app to provide individuals like myself a user-friendly tool to take control of their dietary habits and achieve their wellness goals.")
                    
                    TeamMemberView(name: "\nJonas L.", role: "Co-Founder & Chief Nutritionist", bio: "With a degree in nutrition science and years of experience in the field, Team Member Name is dedicated to ensuring that our app provides accurate nutritional information and helpful tips to support your health journey.")
                    
                    TeamMemberView(name: "\nUtkarsh S.", role: "Co-Founder & Lead Developer", bio: "Our lead developer, Utkarsh, is committed to delivering a seamless user experience. With expertise in app development and a passion for innovation, Utkarsh works tirelessly to implement new features and enhancements to make SimplyDiet the best it can be.")
                    
                    TeamMemberView(name: "\nKarthik M.", role: "Co-Founder & Marketing Director", bio: "Rohan is our marketing guru, responsible for spreading the word about SimplyDiet and connecting with our users. With a background in digital marketing, Karthik brings creative strategies to promote our app and help more people on their health journey.\n\n")
                }
                
                Text("Contact Us")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("\nHave a question or feedback about SimplyDiet? We'd love to hear from you! Feel free to reach out to our team at dontemailus@gmail.com with any inquiries or suggestions.")
                    .font(.body)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("About")
    }
}

struct TeamMemberView: View {
    var name: String
    var role: String
    var bio: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(name)
                .font(.headline)
            
            Text(role)
                .font(.subheadline)
                .foregroundColor(.gray)
                .italic()
            
            Text(bio)
                .font(.body)
        }
    }
}

struct AboutMeView_Previews: PreviewProvider {
    static var previews: some View {
        AboutMeView()
    }
}
