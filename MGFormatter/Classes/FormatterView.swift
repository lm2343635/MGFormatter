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
import SnapKit

enum FormatType {
    case normal
    case attribute
    case boolean
    case string
    case number
    case tab
    case newLine
}

public class FormatterView: UIView {
    
    private struct Const {
        static let trueName = "true"
        static let falseName = "false"
    }
    
    private lazy var codeScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        
        return scrollView
    }()

    private lazy var label = M80AttributedLabel()
    
    private var string: String!
    private var formatterColor: FormatterColor!
    private var tabs = 0
    
    public init(_ string: String, color: FormatterColor, frame: CGRect) {
        super.init(frame: frame)
        format(string, color: color)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func format(_ string: String, color: FormatterColor) {
        self.string = string
        self.formatterColor = color
        
        if let data = string.data(using: .utf8) {
            let json = try! JSON(data: data)
            appendJSON(json, false)
        }
        
        let size = label.sizeThatFits(CGSize.init(width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude))
        label.frame = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        label.backgroundColor = .clear

        codeScrollView.contentSize = CGSize.init(width: self.bounds.width, height: size.height)
        codeScrollView.addSubview(label)
        addSubview(codeScrollView)
        
        codeScrollView.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    // Append a json object, do not show comma at last if withComma is false.
    private func appendJSON(_ json: JSON, _ withComma: Bool) {
        // If JSON is an array, handle it as an array rather than an object.
        if let array = json.array {
            appendJSONArray(array)
            return
        }
        // Handle the json as an object.
        tabs += 1
        append("{\n", type: .normal)
        for (key, subJson): (String, JSON) in json {
            appendTab(tabs)
            append(key, type: .attribute)
            if let boolean = subJson.bool {
                append(boolean ? Const.trueName : Const.falseName, type: .boolean)
            } else if let string = subJson.string {
                append(string, type: .string)
            } else if let double = subJson.double {
                if double.truncatingRemainder(dividingBy: 1) == 0 {
                    append(String(format: "%.0f", double), type: .number)
                } else {
                    append(String(double), type: .number)
                }
            } else if let array = subJson.array  {
                appendJSONArray(array)
            } else {
                appendJSON(subJson, true)
            }
            newLine()
        }
        tabs -= 1
        appendTab(tabs)
        append("}", type: .normal)
        if tabs > 0 && withComma {
            append(", ", type: .normal)
        }
    }
    
    // Append a json array with type [JSON]
    private func appendJSONArray(_ array: [JSON]) {
        append("[\n", type: .normal)
        tabs += 1
        appendTab(tabs)
        for i in 0 ..< array.count {
            appendJSON(array[i], i < array.count - 1)
        }
        tabs -= 1
        newLine()
        appendTab(tabs)
        append("]", type: .normal)
        if tabs > 0 {
            append(",", type: .normal)
        }
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
