//
//  HabitRow.swift
//  Habita
//
//  Created by Seif Abu El-Ela on 12/1/24.
//

import SwiftUI

struct HabitRow: View {
    let habit: Habit
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(habit.name)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(16)
                .font(.title2)
            
            if let completionDate = habit.completionDate {
                if completionDate == DateUtil.getCurrentDate() {
                    Text("You completed '\(habit.name) for today!")
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .padding(16)
                        .background(.accent.opacity(0.1))
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .background(.primary.opacity(0.1))
        .cornerRadius(12.5)
    }
}
