//
//  RegularExpression.swift
//  MDEdittttor
//
//  Created by Eugene Kovs on 14.06.2024.
//  https://github.com/kovs705
//

import UIKit

/**
 *  Highlighter that uses a regular expression to match character
 *  sequences to highlight.
 */
open class RegularExpressionHighlighter: HighlighterType {
    fileprivate let regularExpression: NSRegularExpression
    fileprivate let attributes: TextAttributes
    
    /// Creates a new instance of the receiver.
    ///   - Parameter regularExpression: The regular expression to use for matching text to highlight.
    ///   - Parameter attributes: The attributes applied to matching text ranges.
    ///   - Returns: An initialized instance of the receiver.
    public init(regularExpression: NSRegularExpression, attributes: TextAttributes) {
        self.regularExpression = regularExpression
        self.attributes = attributes
    }
    
    // MARK: HighlighterType
    open func highlightAttributedString(_ attributedString: NSMutableAttributedString) {
        enumerateMatches(regularExpression, string: attributedString.string) {
            attributedString.addAttributes(self.attributes, range: $0.range)
        }
    }
    
    // MARK: Helpers
    /// Enumerates all matches of the regular expression in the given string and executes a block for each match. This method searches the provided string for matches of the regular expression and executes the provided closure for each match found. The closure receives an `NSTextCheckingResult` object, which contains information about the match, including the range of the match in the string.
    /// - Parameters:
    ///   - regex: The regular expression to use for matching.
    ///   - string: The string to search for matches.
    ///   - block: A closure to execute for each match found. The closure takes a single parameter, `NSTextCheckingResult`, which represents the match found.
    fileprivate func enumerateMatches(_ regex: NSRegularExpression, string: String, using block: (NSTextCheckingResult) -> Void) {
        let range = NSRange(location: 0, length: (string as NSString).length)
        regex.enumerateMatches(in: string, options: [], range: range) { (result, _, _) in
            if let result = result {
                block(result)
            }
        }
    }
}
