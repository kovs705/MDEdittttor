//
//  MarkdownTextStorage.swift
//  MDEdittttor
//
//  Created by Eugene Kovs on 14.06.2024.
//  https://github.com/kovs705
//

import UIKit

/**
 *  Text storage with support for highlighting Markdown.
 */
open class MarkdownTextStorage: HighlighterTextStorage {
    fileprivate let attributes: MarkdownAttributes
    
    // MARK: Initialization
    
    /**
     Creates a new instance of the receiver.
     
     - Parameter attributes: Attributes used to style the text.
     
     - Returns: An initialized instance of MarkdownTextStorage
     */
    public init(attributes: MarkdownAttributes = MarkdownAttributes()) {
        self.attributes = attributes
        super.init()
        commonInit()
        
        if let headerAttributes = attributes.headerAttributes {
            addHighlighter(MDHeader(attributes: headerAttributes))
        }
        addHighlighter(MDLink())
        addHighlighter(MDList(markerPattern: "[*+-]", attributes: attributes.unorderedListAttributes, itemAttributes: attributes.unorderedListItemAttributes))
        addHighlighter(MDList(markerPattern: "\\d+[.]", attributes: attributes.orderedListAttributes, itemAttributes: attributes.orderedListItemAttributes))
        
        // From markdown.pl v1.0.1 <http://daringfireball.net/projects/markdown/>
        
        // Code blocks
        addPattern("(?:\n\n|\\A)((?:(?:[ ]{4}|\t).*\n+)+)((?=^[ ]{0,4}\\S)|\\Z)", attributes.codeBlockAttributes)
        
        // Block quotes
        addPattern("(?:^[ \t]*>[ \t]?.+\n(.+\n)*\n*)+", attributes.blockQuoteAttributes)
        
        // Se-text style headers
        // H1
        addPattern("^(?:.+)[ \t]*\n=+[ \t]*\n+", attributes.headerAttributes?.h1Attributes)
        
        // Emphasis
        addPattern("(\\*|_)(?=\\S)(.+?)(?<=\\S)\\1", attributesForTraits(.traitItalic, attributes.emphasisAttributes))
        
        // Strong
        addPattern("(\\*\\*|__)(?=\\S)(?:.+?[*_]*)(?<=\\S)\\1", attributesForTraits(.traitBold, attributes.strongAttributes))
        
        // Inline code
        addPattern("(`+)(?:.+?)(?<!`)\\1(?!`)", attributes.inlineCodeAttributes)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        attributes = MarkdownAttributes()
        super.init(coder: aDecoder)
        commonInit()
    }
    
    required public init(itemProviderData data: Data, typeIdentifier: String) throws {
        fatalError("init(itemProviderData:typeIdentifier:) has not been implemented")
    }
    
    fileprivate func commonInit() {
        defaultAttributes = attributes.defaultAttributes
    }
    
    // MARK: Helpers
    
    fileprivate func addPattern(_ pattern: String, _ attributes: TextAttributes?) {
        if let attributes = attributes {
            let highlighter = RegularExpressionHighlighter(regularExpression: regexFromPattern(pattern), attributes: attributes)
            addHighlighter(highlighter)
        }
    }
    
    fileprivate func attributesForTraits(_ traits: UIFontDescriptor.SymbolicTraits, _ attributes: TextAttributes?) -> TextAttributes? {
        var newAttributes = attributes
        
        if let defaultFont = defaultAttributes[.font] as? UIFont, attributes == nil {
            newAttributes = [
                .font: fontWithTraits(traits, font: defaultFont)
            ]
        }
        return newAttributes
    }
    
    fileprivate func regexFromPattern(_ pattern: String) -> NSRegularExpression {
        do {
            return try NSRegularExpression(pattern: pattern, options: [])
        } catch {
            fatalError("Invalid regex pattern: \(pattern)")
        }
    }
    
    fileprivate func fontWithTraits(_ traits: UIFontDescriptor.SymbolicTraits, font: UIFont) -> UIFont {
        let descriptor = font.fontDescriptor.withSymbolicTraits(traits) ?? font.fontDescriptor
        return UIFont(descriptor: descriptor, size: font.pointSize)
    }
}
