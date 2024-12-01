//
//  ContentView.swift
//  Habita
//
//  Created by Seif Abu El-Ela on 11/30/24.
//

import SwiftUI

struct HabitaView: View {
    var body: some View {
        NavigationStack {
            if true {
                AuthenticationView()
            } else {
                HomeView()
            }
        }
    }
}

#Preview {
    HabitaView()
}
