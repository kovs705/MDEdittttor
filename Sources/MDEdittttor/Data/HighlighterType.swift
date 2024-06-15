//
//  HighlighterType.swift
//  MDEdittttor
//
//  Created by Eugene Kovs on 14.06.2024.
//  https://github.com/kovs705
//

import UIKit

/// Used with `HighlighterTextStorage` to add support for highlighting
/// text inside the text storage when the text changes.
public protocol HighlighterType {
    /**
     *  Highlights the text in attributedString
     */
    func highlightAttributedString(_ attributedString: NSMutableAttributedString)
}

extension HighlighterType {
    
    /// Enumerates all matches of the regular expression in the given string and executes a block for each match.
    ///  - Parameter regex: The regular expression to use for matching.
    ///  - Parameter string: The string to search for matches.
    ///  - Parameter block: A closure to execute for each match found. The closure takes a single parameter, `NSTextCheckingResult`, which represents the match found.
    /// 
    /// This method searches the provided string for matches of the regular expression and executes the provided closure for each match found. The closure receives an `NSTextCheckingResult` object, which contains information about the match, including the range of the match in the string.
    func enumerateMatches(_ regex: NSRegularExpression, string: String, using block: (NSTextCheckingResult) -> Void) {
        let range = NSRange(location: 0, length: (string as NSString).length)
        regex.enumerateMatches(in: string, options: [], range: range) { (result, _, _) in
            if let result = result {
                block(result)
            }
        }
    }
    
    /// Creates a regular expression from a pattern string.
    ///  - Parameter pattern: The pattern string to create the regular expression from.
    ///  - Returns: A compiled `NSRegularExpression` object.
    static func regexFromPattern(_ pattern: String) -> NSRegularExpression {
        do {
            return try NSRegularExpression(pattern: pattern, options: [.anchorsMatchLines])
        } catch {
            fatalError("Invalid regex pattern: \(pattern)")
        }
    }
}
