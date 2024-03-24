//
//  Settings.swift
//  HealthDietApp
//
//  Created by Jonas Lazebnik on 3/23/24.
//

import SwiftUI

struct Settings: View {
    @AppStorage("enableNotifications") var enableNotifications: Bool = false
    @AppStorage("lightMode") var lightMode: Bool = false
    @AppStorage("darkMode") var darkMode: Bool = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("General")) {
                    Toggle("Enable Notifications", isOn: $enableNotifications)
                    
                    Toggle("Always Light Mode", isOn: $lightMode)
                        .onChange(of: lightMode) { newValue in
                            if newValue {
                                darkMode = false
                            }
                        }
                        
                    Toggle("Always Dark Mode", isOn: $darkMode)
                        .onChange(of: darkMode) { newValue in
                            if newValue {
                                lightMode = false
                            }
                        }
                }

                // Privacy Policy Link
                Section {
                    NavigationLink("Privacy Policy", destination: PrivacyPolicyView())
                }
                Section {
                    NavigationLink("About", destination:
                        AboutMeView())
                }
            }
            .navigationBarTitle("Settings", displayMode: .large)
            .preferredColorScheme(lightMode ? .light : darkMode ? .dark : nil)
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
