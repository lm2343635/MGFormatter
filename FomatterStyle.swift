//
//  FomatterStyle.swift
//  Alamofire
//
//  Created by mon.ri on 2018/06/18.
//

import UIKit

public class FormatterStyle {
    
    var color: FormatterColor
    var font: UIFont
    
    init(color: FormatterColor, font: UIFont) {
        self.color = color
        self.font = font
    }
    
    public class var `default`: FormatterStyle {
        let font = UIFont(name: "Menlo", size: 12)
        return FormatterStyle(color: .light, font: font)
    }
    
}
