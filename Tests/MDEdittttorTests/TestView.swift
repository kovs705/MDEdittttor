//
//  SwiftUIView.swift
//  
//
//  Created by Eugene Kovs on 14.06.2024.
//

import SwiftUI
import MDEdittttor

@available(iOS 15.0, *)
struct ContentView: View {
    @State private var text: String = "Type your markdown here..."
    
    var body: some View {
        VStack {
            MDEdittttorWrapper(text: $text)
                .frame(height: 300)
                .padding()
            
            Text("Preview:")
                .font(.headline)
                .padding(.top)
            
            ScrollView {
                Text(text)
                    .padding()
            }
        }
        .padding()
    }
}

@available(iOS 15.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
