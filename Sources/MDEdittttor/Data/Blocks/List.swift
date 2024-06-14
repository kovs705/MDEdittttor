//
//  List.swift
//  MDEdittttor
//
//  Created by Eugene Kovs on 14.06.2024.
//  https://github.com/kovs705
//

import UIKit

/// Highlights Markdown lists using specifiable marker patterns.
public final class MDList: HighlighterType {
    fileprivate let regularExpression: NSRegularExpression
    fileprivate let attributes: TextAttributes?
    fileprivate let itemAttributes: TextAttributes?
    
    
    /// Creates a new instance of the receiver.
    ///  - Parameter markerPattern: Regular expression pattern to use for matching list markers.
    ///  - Parameter attributes: Attributes to apply to the entire list.
    ///  - Parameter itemAttributes: Attributes to apply to list items (excluding list markers)
    ///  - Returns: An initialized instance of the receiver.
    public init(markerPattern: String, attributes: TextAttributes?, itemAttributes: TextAttributes?) {
        self.regularExpression = MDList.listItemRegexWithMarkerPattern(markerPattern)
        self.attributes = attributes
        self.itemAttributes = itemAttributes
    }
    
    // MARK: HighlighterType
    
    public func highlightAttributedString(_ attributedString: NSMutableAttributedString) {
        if attributes == nil && itemAttributes == nil { return }
        
        enumerateMatches(regularExpression, string: attributedString.string) {
            if let attributes = self.attributes {
                attributedString.addAttributes(attributes, range: $0.range)
            }
            if let itemAttributes = self.itemAttributes {
                attributedString.addAttributes(itemAttributes, range: $0.range(at: 1))
            }
        }
    }
    
    private static func listItemRegexWithMarkerPattern(_ pattern: String) -> NSRegularExpression {
        // From markdown.pl v1.0.1 <http://daringfireball.net/projects/markdown/>
        return regexFromPattern("^(?:[ ]{0,3}(?:\(pattern))[ \t]+)(.+)\n")
    }
}


