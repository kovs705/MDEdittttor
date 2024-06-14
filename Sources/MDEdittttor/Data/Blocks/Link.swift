//
//  Link.swift
//  MDEdittttor
//
//  Created by Eugene Kovs on 14.06.2024.
//  https://github.com/kovs705
//

import UIKit

/// Highlights Markdown links (not including link references)
public final class MDLink: HighlighterType {
    // From markdown.pl v1.0.1 <http://daringfireball.net/projects/markdown/>
    fileprivate static let LinkRegex = regexFromPattern("\\[([^\\[]+)\\]\\([ \t]*<?(.*?)>?[ \t]*((['\"])(.*?)\\4)?\\)")
    
    // MARK: HighlighterType
    
    public func highlightAttributedString(_ attributedString: NSMutableAttributedString) {
        let string = attributedString.string
        enumerateMatches(type(of: self).LinkRegex, string: string) {
            let URLString = (string as NSString).substring(with: $0.range(at: 2))
            let linkAttributes: [NSAttributedString.Key: Any] = [
                .link: URLString
            ]
            attributedString.addAttributes(linkAttributes, range: $0.range)
        }
    }
    
}
