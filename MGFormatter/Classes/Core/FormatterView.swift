//
//  FormatterView.swift
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
import SwiftyJSON
import Fuzi
import AttributedTextView

enum JSONCodeType {
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
    private var style: FormatterStyle = .jsonLight
    
    private var tabs = 0
    private var attributer = Attributer("")
    
    private var tagStack: [String] = []
    
    public func format(string: String, style: FormatterStyle) {
        self.string = string
        self.style = style

        addSubview(codeTextView)
        createConstraints()
        
        switch style.type {
        case .json(_):
            if let data = string.data(using: .utf8), let json = try? JSON(data: data) {
                appendJSON(json, false)
            }
            
        case .html(_):
            if let document = try? HTMLDocument(string: string, encoding: .utf8), let root = document.root  {
                appendHTML(root)
            }
        case .none(let color):
            attributer = string.color(color)
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
        attributer = attributer.append(tab)
    }
    
    private func newLine() {
        attributer = attributer.append("\n")
    }
    
    private func createConstraints() {
        codeTextView.translatesAutoresizingMaskIntoConstraints = false
        codeTextView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        codeTextView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        codeTextView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        codeTextView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
}

// MARK: HTML Formatter
extension FormatterView {
    
    private func appendHTML(_ element: XMLElement?) {
        guard let element = element, let tag = element.tag else {
            return
        }
        
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
        if case let .html(color) = style.type {
            switch type {
            case .normal:
                attributer = attributer.append(text.color(color.normal))
            case .startTag(let attributes):
                attributer = attributer.append("<\(text)".color(color.tag))
                for (key, value) in attributes {
                    attributer = attributer.append(" \(key)".color(color.attributeName) + "=".color(color.normal) + "\"\(value)\"".color(color.attributeValue))
                }
                attributer = attributer.append(">".color(color.tag))
            case .endTag:
                attributer = attributer.append("</\(text)>".color(color.tag))
            }
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
        appendJSONNode("{\n", type: .normal)
        for (key, subJson): (String, JSON) in json {
            appendTab(tabs)
            appendJSONNode(key, type: .attribute)
            if let boolean = subJson.bool {
                appendJSONNode(boolean ? Const.trueName : Const.falseName, type: .boolean)
            } else if let string = subJson.string {
                appendJSONNode(string, type: .string)
            } else if let double = subJson.double {
                if double.truncatingRemainder(dividingBy: 1) == 0 {
                    appendJSONNode(String(format: "%.0f", double), type: .number)
                } else {
                    appendJSONNode(String(double), type: .number)
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
        appendJSONNode("}", type: .normal)
        if tabs > 0 && withComma {
            appendJSONNode(", ", type: .normal)
        }

    }
    
    // Append a json array with type [JSON]
    private func appendJSONArray(_ array: [JSON]) {
        appendJSONNode("[\n", type: .normal)
        tabs += 1
        appendTab(tabs)
        for i in 0 ..< array.count {
            appendJSON(array[i], i < array.count - 1)
        }
        tabs -= 1
        newLine()
        appendTab(tabs)
        appendJSONNode("]", type: .normal)
        if tabs > 0 {
            appendJSONNode(",", type: .normal)
        }
    }
    
    private func appendJSONNode(_ text: String, type: JSONCodeType) {
        if case let .json(color) = style.type {
            switch type {
            case .normal:
                attributer = attributer.append(text.color(color.normal))
            case .attribute:
                attributer = attributer.append("\"\(text)\": ".color(color.attribute))
            case .boolean:
                attributer = attributer.append("\(text),".color(color.boolean))
            case .number:
                attributer = attributer.append("\(text),".color(color.number))
            case .string:
                attributer = attributer.append("\"\(text)\",".color(color.string))
            }
        }
    }

}
