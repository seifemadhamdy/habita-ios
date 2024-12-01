//
//  HomeView.swift
//  Habita
//
//  Created by Seif Abu El-Ela on 12/1/24.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    var body: some View {
        VStack {
            Text("HomeView")
            
            Button(action: {
                do {
                    try Auth.auth().signOut()
                } catch {
                }
            }) {
                Text("Sign Out")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(25)
                    .foregroundColor(.white)
            }
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
