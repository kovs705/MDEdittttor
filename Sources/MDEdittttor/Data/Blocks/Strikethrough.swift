//
//  Strikethrough.swift
//  MDEdittttor
//
//  Created by Eugene Kovs on 14.06.2024.
//  https://github.com/kovs705
//

import UIKit

/// Highlights ~~strikethrough~~ in Markdown text (unofficial extension)
public final class MDStrikethrough: HighlighterType {
    fileprivate static let StrikethroughRegex = regexFromPattern("(~~)(?=\\S)(.+?)(?<=\\S)\\1")
    fileprivate let attributes: TextAttributes?
    
    /// Creates a new instance of the receiver.
    ///  - Parameter attributes: Optional additional attributes to apply to strikethrough text.
    ///  - Returns: An initialized instance of the receiver.
    public init(attributes: TextAttributes? = nil) {
        self.attributes = attributes
    }
    
    // MARK: HighlighterType
    public func highlightAttributedString(_ attributedString: NSMutableAttributedString) {
        enumerateMatches(type(of: self).StrikethroughRegex, string: attributedString.string) {
            var strikethroughAttributes: TextAttributes = [
                .strikethroughStyle: NSUnderlineStyle.single.rawValue as AnyObject
            ]
            if let attributes = self.attributes {
                for (key, value) in attributes {
                    strikethroughAttributes[key] = value
                }
            }
            attributedString.addAttributes(strikethroughAttributes, range: $0.range(at: 2))
        }
    }
}
