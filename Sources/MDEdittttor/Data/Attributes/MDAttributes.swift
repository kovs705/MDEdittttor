//
//  MDAttributes.swift
//  MDEdittttor
//
//  Created by Eugene Kovs on 14.06.2024.
//  https://github.com/kovs705
//

import UIKit

@available(iOS 16.0, *)
/// Encapsulates the attributes to use for styling various types of Markdown elements.
public struct MarkdownAttributes {
    public var defaultAttributes: TextAttributes = [
        .font: UIFont.preferredFont(forTextStyle: .body),
        .foregroundColor: UIColor.label
    ]
    
    public var strongAttributes: TextAttributes?
    public var emphasisAttributes: TextAttributes?
    
    public struct HeaderAttributes {
        public var h1Attributes: TextAttributes? = [
            .font: UIFont.preferredFont(forTextStyle: .largeTitle)
        ]
        
        public var h2Attributes: TextAttributes? = [
            .font: UIFont.preferredFont(forTextStyle: .title1)
        ]
        
        public var h3Attributes: TextAttributes? = [
            .font: UIFont.preferredFont(forTextStyle: .title2)
        ]
        
        public var h4Attributes: TextAttributes? = [
            .font: UIFont.preferredFont(forTextStyle: .title3)
        ]
        
        public var h5Attributes: TextAttributes? = [
            .font: UIFont.preferredFont(forTextStyle: .headline)
        ]
        
        public var h6Attributes: TextAttributes? = [
            .font: UIFont.preferredFont(forTextStyle: .headline)
        ]
        
        func attributesForHeaderLevel(_ level: Int) -> TextAttributes? {
            switch level {
            case 1: return h1Attributes
            case 2: return h2Attributes
            case 3: return h3Attributes
            case 4: return h4Attributes
            case 5: return h5Attributes
            case 6: return h6Attributes
            default: return nil
            }
        }
        
        public init() {}
    }
    
    public var headerAttributes: HeaderAttributes? = HeaderAttributes()
    
    fileprivate static let MonospaceFont: UIFont = {
        let bodyFont = UIFont.preferredFont(forTextStyle: .body)
        let size = bodyFont.pointSize
        return UIFont(name: "Menlo", size: size) ?? UIFont(name: "Courier", size: size) ?? bodyFont
    }()
    
    public var codeBlockAttributes: TextAttributes? = [
        .font: MarkdownAttributes.MonospaceFont
    ]
    
    public var inlineCodeAttributes: TextAttributes? = [
        .font: MarkdownAttributes.MonospaceFont
    ]
    
    public var blockQuoteAttributes: TextAttributes? = [
        .foregroundColor: UIColor.darkGray
    ]
    
    public var orderedListAttributes: TextAttributes? = [
        .font: fontWithTraits(.traitBold, font: UIFont.preferredFont(forTextStyle: .body))
    ]
    
    public var orderedListItemAttributes: TextAttributes? = [
        .font: UIFont.preferredFont(forTextStyle: .body),
        .foregroundColor: UIColor.darkGray
    ]
    
    public var unorderedListAttributes: TextAttributes? = [
        .font: fontWithTraits(.traitBold, font: UIFont.preferredFont(forTextStyle: .body))
    ]
    
    public var unorderedListItemAttributes: TextAttributes? = [
        .font: UIFont.preferredFont(forTextStyle: .body),
        .foregroundColor: UIColor.darkGray
    ]
    
    public init() {}
}
