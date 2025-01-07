//
//  MDEdittttorUI.swift
//  MDEdittttor
//
//  Created by Eugene Kovs on 14.06.2024.
//  https://github.com/kovs705
//

import SwiftUI
import UIKit

@available(iOS 16.0, *)
public struct MDEdittttorWrapper: UIViewRepresentable {
    
    @Binding public var text: String
    @Binding public var height: CGFloat
    
    var isScrollEnabled: Bool
    
    init(
        text: Binding<String>,
        height: Binding<CGFloat>,
        isScrollEnabled: Bool = true
    ) {
        self._text = text
        self._height = height
        self.isScrollEnabled = isScrollEnabled
    }
    
    public func makeUIView(context: Context) -> MDEdittttor {
        let editor = MDEdittttor.defaultMarkdownTextView()
        
        editor.delegate = context.coordinator
        editor.textContainer.lineFragmentPadding = 0
        editor.textContainerInset = .zero
        
        editor.isScrollEnabled = isScrollEnabled
        
        return editor
    }
    
    public func updateUIView(_ uiView: MDEdittttor, context: Context) {
        if uiView.text != text {
            uiView.text = text
        }
        
        DispatchQueue.main.async {
            self.height = uiView.contentSize.height
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
            
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                parent.height = textView.contentSize.height
            }
        }
        
        public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return (textView as? MDEdittttor)?.textView(textView, shouldChangeTextIn: range, replacementText: text) ?? true
        }
    }
}

@available(iOS 16.0, *)
#Preview(body: {
    
    MDEdittttorWrapper(text: .constant("\(ExampleText.hello)"), height: .constant(120))
        .frame(minHeight: 120)
        .padding()
        .colorScheme(.light)
})
