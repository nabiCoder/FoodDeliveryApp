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
}
