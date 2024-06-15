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
    fileprivate static let FencedCodeRegex = regexFromPattern("^(`{3})(?:.*)?$\n[\\s\\S]*\n\\1$")
    
    /// Creates a new instance of the receiver.
    ///   - Parameter attributes: Attributes to apply to fenced code blocks.
    ///   - Returns: A new instance of the receiver.
    public init(attributes: TextAttributes) {
        super.init(regularExpression: type(of: self).FencedCodeRegex, attributes: attributes)
    }
}
