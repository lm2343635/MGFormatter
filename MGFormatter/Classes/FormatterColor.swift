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
