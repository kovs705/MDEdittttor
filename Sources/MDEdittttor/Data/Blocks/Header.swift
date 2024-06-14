//
//  Header.swift
//  MDEdittttor
//
//  Created by Eugene Kovs on 14.06.2024.
//  https://github.com/kovs705
//

import UIKit

/// Highlights atx-style Markdown headers.
public final class MDHeader: HighlighterType {
    // From markdown.pl v1.0.1 <http://daringfireball.net/projects/markdown/>
    fileprivate static let HeaderRegex = regexFromPattern("^(\\#{1,6})[ \t]*(?:.+?)[ \t]*\\#*\n+")
    fileprivate let attributes: MarkdownAttributes.HeaderAttributes
    
    /// Creates a new instance of the receiver.
    ///  - Parameter attributes: Attributes to apply to Markdown headers.
    ///  - Returns: An initialized instance of the receiver.
    public init(attributes: MarkdownAttributes.HeaderAttributes) {
        self.attributes = attributes
    }
    
    // MARK: HighlighterType
    public func highlightAttributedString(_ attributedString: NSMutableAttributedString) {
        enumerateMatches(type(of: self).HeaderRegex, string: attributedString.string) {
            let level = $0.range(at: 1).length
            if let attributes = self.attributes.attributesForHeaderLevel(level) {
                attributedString.addAttributes(attributes, range: $0.range)
            }
        }
    }
}
