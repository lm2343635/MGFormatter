//
//  FormatterColor.swift
//  Pods
//
//  Created by lidaye on 13/08/2017.
//
//

import UIKit

public class FormatterColor {
    
    var normal: UIColor
    var attribute: UIColor
    var boolean: UIColor
    var string: UIColor
    var number: UIColor
    
    init(normal: UIColor, attribute: UIColor, boolean: UIColor, string: UIColor, number: UIColor) {
        self.normal = normal
        self.attribute = attribute
        self.boolean = boolean
        self.string = string
        self.number = number
    }
    
    public class var light: FormatterColor {
        return FormatterColor(normal: .darkGray, attribute: .red, boolean: .brown, string: .blue, number: .purple)
    }
    
    public class var dark: FormatterColor {
        return FormatterColor(normal: .white, attribute: .magenta, boolean: .cyan, string: .green, number: .orange)
    }
    
}

enum FormatterType {
    case json
    case xml
    case htm
    case automatic
}

public class FormatterStyle {
    
    var color: FormatterColor
    var font: UIFont
    var lineSpacing: CGFloat
    var type: FormatterType
    
    init(color: FormatterColor, font: UIFont, lineSpacing: CGFloat, type: FormatterType) {
        self.color = color
        self.font = font
        self.lineSpacing = lineSpacing
        self.type = type
    }
    
    public class var light: FormatterStyle {
        let font = UIFont(name: "Menlo", size: 12) ?? UIFont.systemFont(ofSize: 12)
        return FormatterStyle(color: .light, font: font, lineSpacing: 5, type: .automatic)
    }
    
    public class var dark: FormatterStyle {
        let font = UIFont(name: "Menlo", size: 12) ?? UIFont.systemFont(ofSize: 12)
        return FormatterStyle(color: .dark, font: font, lineSpacing: 5, type: .automatic)
    }
    
}
