import Foundation.NSString

extension String {
    func applyPatternOnNumbers(pattern: String, replacementCharacter: Character) -> String {
        let pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        var formattedString = ""
        var pureNumberIndex = pureNumber.startIndex
        
        for patternCharacter in pattern where pureNumberIndex < pureNumber.endIndex {
            print(patternCharacter)
            if patternCharacter == replacementCharacter {
                formattedString.append(pureNumber[pureNumberIndex])
                pureNumberIndex = pureNumber.index(after: pureNumberIndex)
            } else {
                formattedString.append(patternCharacter)
            }
        }
        return formattedString
    }
    
    var isEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.(ru|com)"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    var isFullName: Bool {
        let nameRegex = "^[A-Z][a-z]+\\s[A-Z][a-z]+$"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return namePredicate.evaluate(with: self)
    }
}
