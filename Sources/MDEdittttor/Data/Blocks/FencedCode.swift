//
//  FencedCode.swift
//  MDEdittttor
//
//  Created by Eugene Kovs on 14.06.2024.
//  https://github.com/kovs705
//

import UIKit

/// Highlights fenced code blocks in Markdown text.
public final class MDFencedCode: RegularExpressionHighlighter {
    fileprivate static let FencedCodeRegex = regexFromPattern("^({3})(?:.*)?$\n[\\s\\S]*\n\\1$")
    
    /// Creates a new instance of the receiver.
    ///   - Parameter attributes: Attributes to apply to fenced code blocks.
    ///   - Returns: A new instance of the receiver.
    public init(attributes: TextAttributes) {
        super.init(regularExpression: type(of: self).FencedCodeRegex, attributes: attributes)
    }
    
    /// Creates a regular expression from a pattern string.
    ///  - Parameter pattern: The pattern string to create the regular expression from.
    ///  - Returns: A compiled `NSRegularExpression` object.
    fileprivate static func regexFromPattern(_ pattern: String) -> NSRegularExpression {
        do {
            return try NSRegularExpression(pattern: pattern, options: [])
        } catch {
            fatalError("Invalid regex pattern: \(pattern)")
        }
    }
}
