//
//  File.swift
//  MDEdittttor
//
//  Created by Eugene Kovs on 14.06.2024.
//  https://github.com/kovs705
//

import UIKit

/**
*  Used with `HighlighterTextStorage` to add support for highlighting
*  text inside the text storage when the text changes.
*/
public protocol HighlighterType {
    /**
    *  Highlights the text in `attributedString`
    */
    func highlightAttributedString(_ attributedString: NSMutableAttributedString)
}
