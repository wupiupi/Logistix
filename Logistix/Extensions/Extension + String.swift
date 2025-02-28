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
        (1...3).forEach { _ in
            let randomIndex = Int.random(in: 0..<letters.count)
            let randomLetter = letters[letters.index(letters.startIndex, offsetBy: randomIndex)]
            result.append(randomLetter)
        }

        // Генерируем 9 случайных цифр
        (1...9).forEach { _ in
            let randomDigit = Int.random(in: 0..<10)
            result.append(String(randomDigit))
        }
        
        result.append("RU")

        return result
    }
}
