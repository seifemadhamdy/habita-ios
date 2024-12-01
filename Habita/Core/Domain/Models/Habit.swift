//
//  Habit.swift
//  Habita
//
//  Created by Seif Abu El-Ela on 12/1/24.
//

import Foundation

struct Habit: Identifiable, Codable {
    var id: String?
    var name: String
    var completionDate: String
    
    // No-argument initializer (required for Firebase)
    init() {
        self.name = ""
        self.completionDate = ""
    }
    
    // Custom initializer
    init(name: String, completionDate: String) {
        self.name = name
        self.completionDate = completionDate
    }
    
    // Firebase uses this key mapping when storing and retrieving data
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case completionDate
    }
}
