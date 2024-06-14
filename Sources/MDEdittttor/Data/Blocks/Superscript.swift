//
//  Superscript.swift
//  MDEdittttor
//
//  Created by Eugene Kovs on 14.06.2024.
//  https://github.com/kovs705
//

import UIKit

/// Highlights superscript in Markdown text
public final class MDSuperscript: HighlighterType {
    fileprivate static let SuperscriptRegex = regexFromPattern("(\\^+)(?:(?:[^\\^\\s\\(][^\\^\\s]*)|(?:\\([^\n\r\\)]+\\)))")
    fileprivate let fontSizeRatio: CGFloat
    
    
    /// Creates a new instance of the receiver.
    ///  - Parameter fontSizeRatio: Ratio to multiply the original font
    ///  - Returns: An initialized instance of the receiver.
    public init(fontSizeRatio: CGFloat = 0.7) {
        self.fontSizeRatio = fontSizeRatio
    }
    
    // MARK: HighlighterType
    public func highlightAttributedString(_ attributedString: NSMutableAttributedString) {
        var previousRange: NSRange?
        var level: Int = 0
        
        enumerateMatches(type(of: self).SuperscriptRegex, string: attributedString.string) {
            level += $0.range(at: 1).length
            let textRange = $0.range
            let attributes = attributedString.attributes(at: textRange.location, effectiveRange: nil)
            
            let isConsecutiveRange: Bool = {
                if let previousRange = previousRange, NSMaxRange(previousRange) == textRange.location {
                    return true
                }
                return false
            }()
            if isConsecutiveRange {
                level += 1
            }
            
            attributedString.addAttributes(MDSuperscript.superscriptAttributes(attributes as TextAttributes, level: level, ratio: self.fontSizeRatio), range: textRange)
            previousRange = textRange
            
            if !isConsecutiveRange {
                level = 0
            }
        }
    }
    
    private static func superscriptAttributes(_ attributes: TextAttributes, level: Int, ratio: CGFloat) -> TextAttributes {
        if let font = attributes[.font] as? UIFont {
            let adjustedFont = UIFont(descriptor: font.fontDescriptor, size: font.pointSize * ratio)
            return [
                NSAttributedString.Key.baselineOffset: level as AnyObject,
                NSAttributedString.Key.font: adjustedFont
            ]
        }
        return [:]
    }
}
