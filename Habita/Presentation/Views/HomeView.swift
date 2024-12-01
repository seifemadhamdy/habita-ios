//
//  HomeView.swift
//  Habita
//
//  Created by Seif Abu El-Ela on 12/1/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var homeViewModel = HomeViewModel()
    @State private var showAddHabitDialog = false
    @State private var isLoggedOut = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if !homeViewModel.habits.isEmpty {
                    List(homeViewModel.habits) { habit in
                        HabitRow(habit: habit)
                    }
                    .listStyle(PlainListStyle())
                    .onAppear {
                        UITableView.appearance().separatorStyle = .none
                    }
                    .padding(.top, 16)
                } else {
                    Text("No Habits")
                        .font(.title2)
                        .foregroundColor(.secondary)
                        .padding()
                }
            }
            .navigationTitle("Habita")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        showAddHabitDialog.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        homeViewModel.signOutUser()
                        isLoggedOut.toggle()
                    }) {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                    }
                }
            }
            .sheet(isPresented: $showAddHabitDialog) {
                AddHabitView { newHabit in
                    homeViewModel.addHabit(habit: newHabit)
                }
            }
            .alert(isPresented: Binding(
                get: { homeViewModel.errorMessage != nil },
                set: { _ in homeViewModel.errorMessage = nil }
            )) {
                Alert(
                    title: Text("An error occured"),
                    message: Text(homeViewModel.errorMessage ?? "An unknown error occurred."),
                    dismissButton: .cancel(Text("Close"))
                )
            }.navigationDestination(isPresented: $isLoggedOut) {
                AuthenticationView().navigationBarBackButtonHidden(true)
            }
        }
    }
}


#Preview {
    HomeView()
}
