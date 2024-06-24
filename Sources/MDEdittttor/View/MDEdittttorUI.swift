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
        editor.textContainer.lineFragmentPadding = 0
        editor.textContainerInset = .zero
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
    
    func sizeThatFits(_ proposal: ProposedViewSize, uiView: UITextView, context: Context) -> CGSize? {
        let dimensions = proposal.replacingUnspecifiedDimensions(
            by: .init(
                width: 0,
                height: CGFloat.greatestFiniteMagnitude
            )
        )
        
        let calculatedHeight = calculateTextViewHeight(
            containerSize: dimensions,
            attributedString: uiView.attributedText
        )
        
        return .init(
            width: dimensions.width,
            height: calculatedHeight
        )
    }
    
    private func calculateTextViewHeight(containerSize: CGSize,
                                         attributedString: NSAttributedString) -> CGFloat {
        let boundingRect = attributedString.boundingRect(
            with: .init(width: containerSize.width, height: .greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            context: nil
        )
        
        return boundingRect.height
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

@available(iOS 16.0, *)
#Preview(body: {
    @State var text = "\(ExampleText.hello)"
    return VStack {
        Text("Hello")
        MDEdittttorWrapper(text: $text)
    }
})
