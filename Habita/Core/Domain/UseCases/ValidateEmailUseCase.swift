//
//  ValidateEmailUseCase.swift
//  Habita
//
//  Created by Seif Abu El-Ela on 12/1/24.
//

import Foundation

class ValidateEmailUseCase {
    func execute(email: String) -> Bool {
        let emailPattern = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let regex = try? NSRegularExpression(pattern: emailPattern, options: [])
        let range = NSRange(location: 0, length: email.count)
        
        return !email.isEmpty && regex?.firstMatch(in: email, options: [], range: range) != nil
    }
}
