//
//  HomeViewModel.swift
//  Habita
//
//  Created by Seif Abu El-Ela on 12/1/24.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import Combine

class HomeViewModel: ObservableObject {
    private let database = Database.database().reference()
    private let firebaseAuth = Auth.auth()
    
    @Published var habits: [Habit] = []
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchUserHabits()
    }
    
    private func fetchUserHabits() {
        guard let userID = firebaseAuth.currentUser?.uid else {
            errorMessage = "User is not authenticated"
            return
        }
        
        let userHabitsRef = database.child("habits").child(userID)
        
        userHabitsRef.observe(.value) { snapshot in
            if snapshot.exists() {
                var loadedHabits: [Habit] = []
                
                for child in snapshot.children {
                    if let childSnapshot = child as? DataSnapshot,
                       let habit = try? childSnapshot.data(as: Habit.self) {
                        loadedHabits.append(habit)
                    }
                }
                
                DispatchQueue.main.async {
                    self.habits = loadedHabits
                }
            } else {
                DispatchQueue.main.async {
                    self.habits = []
                }
            }
        } withCancel: { error in
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func addHabit(habit: Habit) {
        guard let userID = firebaseAuth.currentUser?.uid else {
            errorMessage = "User is not authenticated"
            return
        }
        
        let userHabitsRef = database.child("habits").child(userID)
        userHabitsRef.childByAutoId().setValue(habit.toDictionary())
    }
    
    func signOutUser() {
        do {
            try firebaseAuth.signOut()
        } catch {
            errorMessage = "Failed to sign out: \(error.localizedDescription)"
        }
    }
}
