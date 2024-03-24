//
//  PrivacyPolicy.swift
//  HealthDietApp
//
//  Created by J L on 3/24/24.
//

import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Your privacy is important to us. It is our policy to respect your privacy, and we see it fit that all of your information is stored with you! That's right, we store none of the information you enter in our app. Get recording!\n\n")
                
                Text("This policy is effective as of ")                    .font(.subheadline) +
                Text("03/24/24").bold()                    .font(.subheadline)
                Text("and was last updated on ")                    .font(.subheadline) +
                Text("03/24/24.").bold()                    .font(.subheadline)
                Text("\nAll the data stays on your device, always.")
                    .italic()
                    .font(.subheadline)
            }
            .padding()
        }
        .navigationTitle("Privacy Policy")
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
