//
//  Habit.swift
//  Habita
//
//  Created by Seif Abu El-Ela on 12/1/24.
//

import Foundation

struct Habit: Identifiable, Decodable {
    var id: String
    var name: String
    var completionDate: String?
    
    init(id: String = UUID().uuidString, name: String, completionDate: String? = nil) {
        self.id = id
        self.name = name
        self.completionDate = completionDate
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "name": name,
            "completionDate": completionDate ?? NSNull()
        ]
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case completionDate
    }
}
