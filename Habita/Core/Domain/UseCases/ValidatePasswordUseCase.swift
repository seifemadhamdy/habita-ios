//
//  ValidatePasswordUseCase.swift
//  Habita
//
//  Created by Seif Abu El-Ela on 12/1/24.
//

import Foundation

class ValidatePasswordUseCase {
    func execute(password: String) -> Bool {
        let passwordPattern = "^(?=.*[0-9])(?=.*[A-Z])(?=.*[@#$%^&+=!])(?=\\S+$).{8,}$"
        let regex = try? NSRegularExpression(pattern: passwordPattern, options: [])
        let range = NSRange(location: 0, length: password.count)
        
        return regex?.firstMatch(in: password, options: [], range: range) != nil
    }
}
