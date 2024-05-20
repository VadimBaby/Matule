//
//  String.swift
//  Matule
//
//  Created by Вадим Мартыненко on 10.05.2024.
//

import Foundation

extension String {
    var isValidateEmail: Bool {
        let emailRegex = "^[a-z0-9]+@[a-z0-9]+\\.[a-z]{2,}$"
      //  let emailRegei = "^[a-z0-9]+@[a-z0-9]+\\.[a-z]{2,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return predicate.evaluate(with: self)
    }
    
    func turnToPassword() -> String {
        let replaceLetters: [String: [String]] = [
            " ": ["_", "__"],
            "й": ["i"],
            "ц": ["c"],
            "у": ["y", "u"],
            "к": ["k", "c"],
            "е": ["e"],
            "н": ["n", "№"],
            "г": ["g"],
            "ш": ["sh", "Sh", "sH"],
            "щ": ["sh", "Sh", "sH"],
            "з": ["z"],
            "х": ["x", "ks", "Ks", "Sk"],
            "ъ": ["|"],
            "ё": ["yo", "Yo", "yO"],
            "ф": ["f"],
            "ы": ["b|"],
            "в": ["v", "w"],
            "а": ["a"],
            "п": ["p"],
            "р": ["r"],
            "о": ["o", "0", "()"],
            "л": ["l"],
            "д": ["d"],
            "ж": ["sh", "Sh", "sH"],
            "э": ["er"],
            "я": ["ya"],
            "ч": ["ch", "4"],
            "с": ["s", "c", "$"],
            "м": ["m"],
            "и": ["i"],
            "т": ["t"],
            "ь": ["b", "9", "|"],
            "б": ["b"],
            "ю": ["u", "|o", "|0"],
        ]
        
        
        var password: String = ""
        
        self.forEach { element in
            let replaceElements: [String]? = replaceLetters["\(element.lowercased())"]
            
            if let replaceElements {
                let chance = Int.random(in: 0...replaceElements.count - 1)
                
                let letter = replaceElements[chance]
                
                let chanceUp = Int.random(in: 1...4)
                
                if chanceUp == 4 {
                    password += letter.uppercased()
                } else {
                    password += letter
                }
            } else {
                password += "\(element)"
            }
        }
        
        return password
    }
}
