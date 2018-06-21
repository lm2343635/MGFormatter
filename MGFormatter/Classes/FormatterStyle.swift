//
//  FormatterColor.swift
//  Pods
//
//  Created by lidaye on 13/08/2017.
//
//

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
    
}
