//
//  FormatterView.swift
//  Pods
//
//  Created by lidaye on 13/08/2017.
//
//

import UIKit
import SwiftyJSON
import M80AttributedLabel

enum FormatType {
    case normal
    case attribute
    case boolean
    case string
    case number
    case tab
    case newLine
}

public class FormatterView: UIScrollView {

    private let label = M80AttributedLabel()
    
    private var string: String!
    private var formatterColor: FormatterColor!
    private var tabs = 0

    public init(_ string: String, color: FormatterColor, frame: CGRect) {
        super.init(frame: frame)
        format(string, color: color)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func format(_ string: String, color: FormatterColor) {
        self.string = string
        self.formatterColor = color
        
        if let data = string.data(using: .utf8) {
            let json = JSON(data: data)
            appendJSON(json)
        }
        
        let size = label.sizeThatFits(CGSize.init(width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude))
        label.frame = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        label.backgroundColor = UIColor.clear
        
        self.contentSize = CGSize.init(width: self.bounds.width, height: size.height)
        self.addSubview(label)
    }

    private func appendJSON(_ json: JSON) {
        tabs += 1
        append("{\n", type: .normal)
        for (key, subJson):(String, JSON) in json {
            appendTab(tabs)
            append(key, type: .attribute)
            if let boolean = subJson.bool {
                append(boolean ? "true" : "false", type: .boolean)
            } else if let string = subJson.string {
                append(string, type: .string)
            } else if let double = subJson.double {
                if double.truncatingRemainder(dividingBy: 1) == 0 {
                    append(String(format: "%.0f", double), type: .number)
                } else {
                    append(String(double), type: .number)
                }
            } else if let array = subJson.array  {
                append("[\n", type: .normal)
                tabs += 1
                appendTab(tabs)
                for i in 0 ..< array.count {
                    appendJSON(array[i])
                    if (i < array.count - 1) {
                        append(", ", type: .normal)
                    }
                }
                tabs -= 1
                newLine()
                appendTab(tabs)
                append("]", type: .normal)
            } else {
                appendJSON(subJson)
            }
            newLine()
        }
        tabs -= 1
        appendTab(tabs)
        append("}", type: .normal)
    }

    private func append(_ text: String, type: FormatType) {
        switch type {
        case .normal:
            appendAttributedText(text, color: formatterColor.normal)
        case .attribute:
            appendAttributedText("\"\(text)\": ", color: formatterColor.attribute)
        case .boolean:
            appendAttributedText("\(text),", color: formatterColor.boolean)
        case .number:
            appendAttributedText("\(text),", color: formatterColor.number)
        case .string:
            appendAttributedText("\"\(text)\",", color: formatterColor.string)
        default:
            break
        }
    }
    
    private func appendTab(_ n: Int) {
        var tab = ""
        for _ in 0 ..< n {
            tab += "  "
        }
        append(tab, type: .normal)
    }
    
    private func newLine() {
        append("\n", type: .normal)
    }
    
    private func appendAttributedText(_ text: String, color: UIColor)  {
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.m80_setTextColor(color)
        attributedText.m80_setFont(UIFont(name: "Menlo", size: 12)!)
        label.appendAttributedText(attributedText)
    }

}
