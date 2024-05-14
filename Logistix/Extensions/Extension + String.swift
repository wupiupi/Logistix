//
//  Extension + String.swift
//  Logistix
//
//  Created by Paul Makey on 14.05.24.
//

import Foundation

extension String {
    var formattedDate: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZZZZ"
        if let date = dateFormatter.date(from: self) {
            print(date)
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: date)
        }
        return nil
    }
}

extension String {
    static func generateTrackNum() -> String {
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        var result = ""

        // Генерируем три случайные буквы
        for _ in 1...3 {
            let randomIndex = Int.random(in: 0..<letters.count)
            let randomLetter = letters[letters.index(letters.startIndex, offsetBy: randomIndex)]
            result.append(randomLetter)
        }

        // Генерируем 9 случайных цифр
        for _ in 1...9 {
            let randomDigit = Int.random(in: 0..<10)
            result.append(String(randomDigit))
        }

        // Генерируем две случайные буквы. Убери коммент, и 50 строку, если хочешь любые 2 цифры
        /*
        for _ in 1...2 {
            let randomIndex = Int.random(in: 0..<letters.count)
            let randomLetter = letters[letters.index(letters.startIndex, offsetBy: randomIndex)]
            result.append(randomLetter)
        }
         */
        
        result.append("RU")

        return result
    }
}
