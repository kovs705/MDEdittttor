//
//  MDEdittttor.swift
//  MDEdittttor
//
//  Created by Eugene Kovs on 14.06.2024.
//  https://github.com/kovs705
//

import UIKit

/// Text view with support for highlighting Markdown syntax.
open class MDEdittttor: UITextView, UITextViewDelegate {
    
    /// Default markdown text view init method. Style for this project. Using modified markdown attributes file.
    public class func defaultMarkdownTextView() -> MDEdittttor {
        let attributes = MarkdownAttributes()
        let textStorage = MarkdownTextStorage(attributes: attributes)
        do {
            textStorage.addHighlighter(try LinkHighlighter())
        } catch let error {
            fatalError("Error initializing LinkHighlighter: \(error)")
        }
        textStorage.addHighlighter(MDStrikethrough())
        textStorage.addHighlighter(MDSuperscript())
        
        if let codeBlockAttributes = attributes.codeBlockAttributes {
            textStorage.addHighlighter(MDFencedCode(attributes: codeBlockAttributes))
        }
        
        let textView = MDEdittttor(frame: .zero, textStorage: textStorage)
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }
    
    /// Creates a new instance of the receiver.
    ///   - Parameter frame: The view frame.
    ///   - Parameter textStorage: The text storage. This can be customized by the caller to customize text attributes and add additional highlighters if the defaults are not suitable.
    ///   - Returns: An initialized instance of the receiver.
    public init(frame: CGRect, textStorage: MarkdownTextStorage = MarkdownTextStorage()) {
        let textContainer = NSTextContainer()
        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        super.init(frame: frame, textContainer: textContainer)
        
        // Implement delegate to respond to enter operation.
        self.delegate = self
        
        // Highlight all text initially
        textStorage.highlightAllText()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.superview?.addGestureRecognizer(tapGesture)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UITextViewDelegate
    
    let markdownListRegularExpression = try! NSRegularExpression(pattern: "^[-*] ", options: .caseInsensitive)
    let markdownNumberListRegularExpression = try! NSRegularExpression(pattern: "^\\d*\\. ", options: .caseInsensitive)
    
    open func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if isReturn(text) {
            var objectLine = String(textView.text.prefix(range.location))
            
            let textSplits = objectLine.components(separatedBy: "\n")
            if textSplits.count > 0 {
                objectLine = textSplits.last ?? ""
            }
            
            let objectLineRange = NSRange(location: 0, length: objectLine.count)
            
            // Check matches.
            let listMatches = markdownListRegularExpression.matches(in: objectLine, options: [], range: objectLineRange)
            let numberListMatches = markdownNumberListRegularExpression.matches(in: objectLine, options: [], range: objectLineRange)
            
            if listMatches.count > 0 || numberListMatches.count > 0 {
                if numberListMatches.count > 0 {
                    if let match = numberListMatches.first, match.range.length == (objectLine as NSString).length {
                        let deleteRange = NSRange(location: range.location - match.range.length, length: match.range.length)
                        self.textStorage.deleteCharacters(in: deleteRange)
                        self.selectedRange = NSRange(location: deleteRange.location, length: 0)
                        
                        return false
                    }
                    
                    var number = Int(objectLine.components(separatedBy: ".")[0]) ?? 0
                    number += 1
                    
                    let insertText = "\n\(number). "
                    
                    self.textStorage.insert(NSAttributedString(string: insertText), at: range.location)
                    self.selectedRange = NSRange(location: range.location + (insertText as NSString).length, length: 0)
                    
                    return false
                    
                } else {
                    if let match = listMatches.first, match.range.length == (objectLine as NSString).length {
                        let deleteRange = NSRange(location: range.location - match.range.length, length: match.range.length)
                        self.textStorage.deleteCharacters(in: deleteRange)
                        self.selectedRange = NSRange(location: deleteRange.location, length: 0)
                        
                        return false
                    }
                    
                    let listPrefix = objectLine.components(separatedBy: " ").first ?? ""
                    let insertText = "\n\(listPrefix) "
                    
                    self.textStorage.insert(NSAttributedString(string: insertText), at: range.location)
                    self.selectedRange = NSRange(location: range.location + (insertText as NSString).length, length: 0)
                    
                    return false
                }
            }
        }
        
        return true
    }
    
    open func textViewDidChange(_ textView: UITextView) {
        // Implement any additional behavior when the text changes
    }
    
    // MARK: - Override
    override open func caretRect(for position: UITextPosition) -> CGRect {
        var originalRect = super.caretRect(for: position)
        originalRect.size.height = (font?.lineHeight ?? 16) + 3
        return originalRect
    }
    
    // MARK: - Tool
    func isReturn(_ text: String) -> Bool {
        return text == "\n"
    }
    
    // MARK: - Keyboard
    @objc func dismissKeyboard() {
        self.resignFirstResponder()
    }
}
