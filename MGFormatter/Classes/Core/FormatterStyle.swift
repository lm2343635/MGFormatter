//
//  FormatterColor.swift
//  MGFormatter
//
//  Created by Meng Li on 13/08/2017.
//  Copyright © 2019 MuShare. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

public class JSONColor {
    
    var normal: UIColor
    var attribute: UIColor
    var boolean: UIColor
    var string: UIColor
    var number: UIColor
    
    public init(normal: UIColor, attribute: UIColor, boolean: UIColor, string: UIColor, number: UIColor) {
        self.normal = normal
        self.attribute = attribute
        self.boolean = boolean
        self.string = string
        self.number = number
    }
    
    public class var light: JSONColor {
        return JSONColor(normal: .darkGray,
                         attribute: .red,
                         boolean: .brown,
                         string: .blue,
                         number: .purple)
    }
    
    public class var dark: JSONColor {
        return JSONColor(normal: .white,
                         attribute: .yellow,
                         boolean: .green,
                         string: .cyan,
                         number: .orange)
    }
    
}

public class HTMLColor {
    
    var normal: UIColor
    var tag: UIColor
    var attributeName: UIColor
    var attributeValue: UIColor
    
    public init(normal: UIColor, tag: UIColor, attributeName: UIColor, attributeValue: UIColor) {
        self.normal = normal
        self.tag = tag
        self.attributeName = attributeName
        self.attributeValue = attributeValue
    }
    
    public class var light: HTMLColor {
        return HTMLColor(normal: .darkGray,
                         tag: .orange,
                         attributeName: .blue,
                         attributeValue: .magenta)
    }

    public class var dark: HTMLColor {
        return HTMLColor(normal: .white,
                         tag: .cyan,
                         attributeName: .green,
                         attributeValue: .yellow)
    }

}

public enum FormatterType {
    case json(JSONColor)
    case html(HTMLColor)
    case none(UIColor)
}

public class FormatterStyle {
    
    var font: UIFont
    var lineSpacing: CGFloat
    var type: FormatterType
    
    static let defaultFont = UIFont(name: "Menlo", size: 12) ?? UIFont.systemFont(ofSize: 12)
    
    public init(font: UIFont, lineSpacing: CGFloat, type: FormatterType) {
        self.font = font
        self.lineSpacing = lineSpacing
        self.type = type
    }
    
    public class var jsonLight: FormatterStyle {
        return FormatterStyle(font: defaultFont, lineSpacing: 5, type: .json(.light))
    }
    
    public class var jsonDark: FormatterStyle {
        return FormatterStyle(font: defaultFont, lineSpacing: 5, type: .json(.dark))
    }
    
    public class var htmlLight: FormatterStyle {
        return FormatterStyle(font: defaultFont, lineSpacing: 5, type: .html(.light))
    }
    
    public class var htmlDark: FormatterStyle {
        return FormatterStyle(font: defaultFont, lineSpacing: 5, type: .html(.dark))
    }
    
    public class var noneLight: FormatterStyle {
        return FormatterStyle(font: defaultFont, lineSpacing: 5, type: .none(.darkGray))
    }

    public class var noneDark: FormatterStyle {
        return FormatterStyle(font: defaultFont, lineSpacing: 5, type: .none(.white))
    }

}
