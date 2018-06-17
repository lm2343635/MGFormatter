//
//  FormatterView.swift
//  Pods
//
//  Created by Meng Li on 13/08/2017.
//
//

import UIKit
import SwiftyJSON
import AttributedTextView
import SnapKit

enum CodeType {
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
    
    private lazy var codeTextView = AttributedTextView()
    
    private var string: String = ""
    private var style: FormatterStyle = .light
    
    private var tabs = 0
    private var attributer = Attributer("")
    
    
    public func format(string: String, style: FormatterStyle) {
        self.string = string
        self.style = style
        
        if let data = string.data(using: .utf8) {
            let json = try! JSON(data: data)
            appendJSON(json, false)
        }

        addSubview(codeTextView)
        codeTextView.snp.makeConstraints {
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
        
        codeTextView.attributer = attributer.all.paragraph({
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = style.lineSpacing
            return paragraphStyle
        }()).font(style.font)
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

    private func append(_ text: String, type: CodeType) {
        switch type {
        case .normal:
            attributer = attributer.append(text.color(style.color.normal))
        case .attribute:
            attributer = attributer.append("\"\(text)\": ".color(style.color.attribute))
        case .boolean:
            attributer = attributer.append("\(text),".color(style.color.boolean))
        case .number:
            attributer = attributer.append("\(text),".color(style.color.number))
        case .string:
            attributer = attributer.append("\"\(text)\",".color(style.color.string))
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

}
