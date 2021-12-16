//
//  TIMask.swift
//  YBMaskFieldValidation
//
//  Created by Yani Buchkov on 14.12.21.
//  Copyright © 2021 buchkoff. All rights reserved.
//

import Foundation

public class TIMask {
    // MARK: - Properties
    private var pattern: String
    
    private let numberMaskCharacter: Character = "0"
    private let letterMaskCharacter: Character = "A"
    private let alphanumericMaskCharacter: Character = "#"
    
    // MARK: - Patterns
    /// Init different patterns for different fields
    /// Example: Phone Number: +1 (8) 134-123-11
    /// Example: Postal Code: 000-0000
    init(pattern: String) {
        self.pattern = pattern
    }

    func formattedString(from plainString: String) -> String {
        
        let pattern: [Character] = Array(self.pattern)
        let allowedCharachters = CharacterSet.alphanumerics
        let filteredInput = String(plainString.unicodeScalars.filter(allowedCharachters.contains))
        let input: [Character] = Array(filteredInput)
        var formatted: [Character] = []

        var patternIndex = 0
        var inputIndex = 0
        
        while inputIndex < input.count {
            let inputCharacter = input[inputIndex]
            let allowed: CharacterSet
            
            guard patternIndex < pattern.count else {
                break
            }

            switch pattern[patternIndex] {
            case numberMaskCharacter:
                allowed = .decimalDigits
            case letterMaskCharacter:
                allowed = .letters
            case alphanumericMaskCharacter:
                allowed = .alphanumerics
            default:
                formatted.append(pattern[patternIndex])
                patternIndex += 1
                continue
            }
            
            guard inputCharacter.unicodeScalars.allSatisfy(allowed.contains) else {
                inputIndex += 1
                continue
            }
            
            formatted.append(inputCharacter)
            patternIndex += 1
            inputIndex += 1
        }
        return String(formatted)
    }
}

protocol InputMaskProtocol {
    func formattedString(from plainString: String) -> String
    func mask(_ text: String, range: NSRange, replacementString string: String) -> String
}

extension TIMask: InputMaskProtocol {
    @discardableResult
    public func mask(_ text: String, range: NSRange, replacementString string: String) -> String {
        let string = (text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        return formattedString(from: string)
    }
}
