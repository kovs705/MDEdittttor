//
//  File.swift
//  MDEdittttor
//
//  Created by Eugene Kovs on 14.06.2024.
//  https://github.com/kovs705
//

import UIKit

public typealias TextAttributes = [NSAttributedString.Key: Any]

internal func fontWithTraits(_ traits: UIFontDescriptor.SymbolicTraits, font: UIFont) -> UIFont {
    let combinedTraits = UIFontDescriptor.SymbolicTraits(rawValue: font.fontDescriptor.symbolicTraits.rawValue | traits.rawValue)
    guard let descriptor = font.fontDescriptor.withSymbolicTraits(combinedTraits) else {
        fatalError("Failed to create font descriptor with symbolic traits.")
    }
    return UIFont(descriptor: descriptor, size: font.pointSize)
}

internal func regexFromPattern(_ pattern: String) -> NSRegularExpression {
    do {
        return try NSRegularExpression(pattern: pattern, options: .anchorsMatchLines)
    } catch {
        fatalError("Error constructing regular expression: \(error)")
    }
}

internal func enumerateMatches(_ regex: NSRegularExpression, string: String, block: (NSTextCheckingResult) -> Void) {
    let range = NSRange(location: 0, length: (string as NSString).length)
    regex.enumerateMatches(in: string, options: [], range: range) { (result, _, _) in
        if let result = result {
            block(result)
        }
    }
}
