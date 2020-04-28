//
//  Modifiers.swift
//  CodeDesignApp
//
//  Created by Yashas Rao on 4/27/20.
//  Copyright © 2020 CodeDesign. All rights reserved.
//

import SwiftUI

// Similar to UIView extensions. You can use this to cut away repetitive code. These are all modifiable, so you can pass in the parameters (custom font strings) and save time
struct ShadowModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
    }
}

struct FontModifier: ViewModifier {
    var style: Font.TextStyle
    
    func body(content: Content) -> some View {
        content
            .font(.system(style, design: .default))
    }
}

struct CustomFontModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.custom("WorkSans-Bold", size: 28))
    }
}
