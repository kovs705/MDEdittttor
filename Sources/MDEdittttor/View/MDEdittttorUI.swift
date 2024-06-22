//
//  MDEdittttorUI.swift
//  MDEdittttor
//
//  Created by Eugene Kovs on 14.06.2024.
//  https://github.com/kovs705
//

import SwiftUI
import UIKit

@available(iOS 15.0, *)
public struct MDEdittttorWrapper: UIViewRepresentable {
    public typealias UIViewType = MDEdittttor
    
    @Binding public var text: String
    @State private var dynamicHeight: CGFloat = 100
    
    public init(text: Binding<String>) {
        self._text = text
    }
    
    public func makeUIView(context: Context) -> MDEdittttor {
        let editor = MDEdittttor.defaultMarkdownTextView()
        editor.delegate = context.coordinator
        editor.isScrollEnabled = true
        return editor
    }
    
    public func updateUIView(_ uiView: MDEdittttor, context: Context) {
        
        DispatchQueue.main.async {
            self.dynamicHeight = uiView.contentSize.height
        }
        
        if uiView.text != text {
            uiView.text = text
        }
        
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public class Coordinator: NSObject, UITextViewDelegate {
        var parent: MDEdittttorWrapper
        
        init(_ parent: MDEdittttorWrapper) {
            self.parent = parent
        }
        
        public func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
        
        public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return (textView as? MDEdittttor)?.textView(textView, shouldChangeTextIn: range, replacementText: text) ?? true
        }
    }
}

@available(iOS 15.0, *)
#Preview(body: {
    @State var text = "\(ExampleText.hello)"
    return MDEdittttorWrapper(text: $text)
})
