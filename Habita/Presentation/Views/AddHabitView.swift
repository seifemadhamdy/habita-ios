//
//  AddHabitView.swift
//  Habita
//
//  Created by Seif Abu El-Ela on 12/1/24.
//

import SwiftUI

struct AddHabitView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var habitName: String = ""
    @State private var markAsCompleted = false
    @State private var isEmptyNameError = false
    
    let onSave: (Habit) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $habitName)
                Toggle("Mark as completed", isOn: $markAsCompleted)
            }
            .navigationBarTitle("New Habit", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        if !habitName.isEmpty {
                            let newHabit = Habit(name: habitName, completionDate: markAsCompleted ? DateUtil.getCurrentDate() : nil)
                            onSave(newHabit)
                            presentationMode.wrappedValue.dismiss()
                        } else {
                            isEmptyNameError.toggle()
                        }
                    }.alert(isPresented: $isEmptyNameError) {
                        Alert(
                            title: Text("An error occured"),
                            message: Text("Cannot add a habit with an empty name."),
                            dismissButton: .cancel(Text("Close"))
                        )
                    }
                }
            }
        }
    }
}
