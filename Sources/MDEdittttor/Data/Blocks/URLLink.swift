//
//  URLLink.swift
//  MDEdittttor
//
//  Created by Eugene Kovs on 14.06.2024.
//  https://github.com/kovs705
//

import UIKit

/// Highlights URLs.
public final class LinkHighlighter: HighlighterType {
    fileprivate var detector: NSDataDetector!
    
    public init() throws {
        detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
    }
    
    // MARK: HighlighterType
    public func highlightAttributedString(_ attributedString: NSMutableAttributedString) {
        enumerateMatches(detector, string: attributedString.string) {
            if let URL = $0.url {
                let linkAttributes: [NSAttributedString.Key: Any] = [
                    .link: URL
                ]
                attributedString.addAttributes(linkAttributes, range: $0.range)
            }
        }
    }
}
