//
//  ExampleText.swift
//  MDEdittttor
//
//  Created by Eugene Kovs on 15.06.2024.
//  https://github.com/kovs705
//

import Foundation

enum ExampleText {
    static var hello: String {
        """
# Hello MDEdittttors!

This is a basic text, that will inroduce this interesting package to import Markdown editor to your app!!

Okay, let me show you example of usage:
# Header 1
## Header 2
### Header 3
#### Header 4
##### Header 5
###### Header 6
####### And header 7...

How about some code?
```
import SwiftUI

func createCoolEditor() -> MDEdittttor {}
```
At this moment there are no highlights for different languages, but I hope there will be in the future releases.. yep..

Let's get to the author's [GitHub Page](github.com/kovs705)

This is ~~strikethrough~~ text!

Aaaaand this is ^superscript^ text.

And a list for your plans like:
* Travel to Japan
* Try new language
* Explore the new shop nearby

"""
    }
}
