//
//  FormatterView.swift
//  Pods
//
//  Created by Meng Li on 13/08/2017.
//
//

import UIKit
import SwiftyJSON
import Fuzi
import AttributedTextView
import SnapKit

enum CodeType {
    case normal
    case attribute
    case boolean
    case string
    case number
}

enum XMLCodeType {
    case normal
    case startTag([String: String])
    case endTag
}

public class FormatterView: UIView {
    
    private struct Const {
        static let trueName = "true"
        static let falseName = "false"
    }
    
    private lazy var codeTextView: AttributedTextView = {
        let textView = AttributedTextView()
        textView.backgroundColor = .clear
        return textView
    }()
    
    private var string: String = ""
    private var style: FormatterStyle = .light
    
    private var tabs = 0
    private var attributer = Attributer("")
    
    private var tagStack: [String] = []
    
    public func format(string: String, style: FormatterStyle) {
        self.string = string
        self.style = style
        
        
        
        //        if let let data = string.data(using: .utf8), let json = try? JSON(data: data) {
        //            appendJSON(json, false)
        //        }
        
        if let document = try? HTMLDocument(string: string, encoding: .utf8) {
            if let root = document.root {
                appendHTML(root)
                
            }
        }
        
        addSubview(codeTextView)
        codeTextView.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        codeTextView.attributer = attributer.all.paragraph({
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = style.lineSpacing
            return paragraphStyle
            }()).font(style.font)
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

// MARK: HTML Formatter
extension FormatterView {
    
    private func appendHTML(_ element: XMLElement?) {
        guard let element = element, let tag = element.tag else {
            return
        }
        
        print(tagStack)
        tagStack.append(tag)
        appendHTMLElement(tag, .startTag(element.attributes))
        tabs += 1

        if element.children.count == 0 {
            appendHTMLElement(element.stringValue, .normal)
            
            
        } else {
            newLine()
            for children in element.children {
                appendTab(tabs)
                appendHTML(children)
            }
            appendTab(tabs - 1)
        }
        appendHTMLElement(tagStack[tagStack.count - 1], .endTag)
        tagStack.remove(at: tagStack.count - 1)
        newLine()
        tabs -= 1
    }
    
    private func appendHTMLElement(_ text: String, _ type: XMLCodeType) {
        switch type {
        case .normal:
            attributer = attributer.append(text.color(style.color.normal))
        case .startTag(let attributes):
            attributer = attributer.append("<\(text)".color(style.color.attribute))
            for (key, value) in attributes {
                attributer = attributer.append(" \(key)=\"\(value)\"".color(style.color.normal))
            }
            attributer = attributer.append(">".color(style.color.attribute))
        case .endTag:
            attributer = attributer.append("</\(text)>".color(style.color.attribute))
        }
    }
    
}

// MARK: JSON Formatter
extension FormatterView {
    
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
        }
    }
    

    
}

