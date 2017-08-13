//
//  ViewController.swift
//  MGFormatter
//
//  Created by lm2343635 on 08/13/2017.
//  Copyright (c) 2017 lm2343635. All rights reserved.
//

import UIKit
import SwiftyJSON
import M80AttributedLabel

let string = "{\"result\":{\"messages\":[{\"mid\":\"000000005cb02e93015cb0be48380022\",\"createAt\":1497613879352,\"updateAt\":1497613879352,\"seq\":6,\"title\":\"Sanyo refrigerator\",\"price\":4000,\"cover\":\"/files/picture/000000005cb02e93015cb0be48380022/7edc55ae-551e-49a8-ba40-5f5e99e6a632.jpg\",\"favorites\":1,\"enable\":true,\"cid\":\"000000005bce908d015bd18e59460006\"},{\"mid\":\"000000005cb02e93015cb09afa750005\",\"createAt\":1497611565668,\"updateAt\":1497611565668,\"seq\":1,\"title\":\"A good lamp \",\"price\":1000,\"cover\":\"/files/picture/000000005cb02e93015cb09afa750005/51bcb4a5-5a9a-4e87-95f0-9a7b14de55a5.jpg\",\"favorites\":3,\"enable\":true,\"cid\":\"000000005bce908d015bd18e59460006\"}]},\"status\":200,\"type\":\"application/json\",\"time\":2.56,\"update\":true}"

class ViewController: UIViewController {
    
    var tabs = 0

    let prettyLabel = M80AttributedLabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = string.data(using: .utf8) {
            let json = JSON(data: data)
            appendJSON(json)
        }

        let width = self.view.frame.size.width
        let height = self.view.frame.size.height
        
        //Set pretty scroll view
        let prettySize = prettyLabel.sizeThatFits(CGSize.init(width: width - 10, height: CGFloat.greatestFiniteMagnitude))
        prettyLabel.frame = CGRect.init(x: 5, y: 5, width: prettySize.width, height: prettySize.height)
        prettyLabel.backgroundColor = UIColor.clear
        let prettyScrollView: UIScrollView = {
            let view = UIScrollView(frame: CGRect(x: 0, y: 50, width: width, height: height - 50))
            view.contentSize = CGSize.init(width: width, height: prettySize.height + 70)
            view.addSubview(prettyLabel)
            return view
        }()
        
        view.addSubview(prettyScrollView)

    }
    
    func appendJSON(_ json: JSON) {
        tabs += 1
        appendNormal("{\n")
        for (key, subJson):(String, JSON) in json {
            appendTab(tabs)
            appendAttribute(key)
            if let boolean = subJson.bool {
                appendNormal(boolean ? "true," : "false,")
            } else if let string = subJson.string {
                appendString(string)
            } else if let double = subJson.double {
                if double.truncatingRemainder(dividingBy: 1) == 0 {
                    appendNumber(String(format: "%.0f", double))
                } else {
                    appendNumber(String(double))
                }
            } else if let array = subJson.array  {
                appendNormal("[\n")
                tabs += 1
                appendTab(tabs)
                for i in 0 ..< array.count {
                    appendJSON(array[i])
                    if (i < array.count - 1) {
                        appendNormal(", ")
                    }
                }
                tabs -= 1
                newLine()
                appendTab(tabs)
                appendNormal("]")
            } else {
                appendJSON(subJson)
            }
            newLine()
        }
        tabs -= 1
        appendTab(tabs)
        appendNormal("}")
    }
    
    func appendNormal(_ text: String) {
        appendText(text, color: .black)
    }
    
    func appendAttribute(_ text: String) {
        appendText("\"\(text)\": ", color: .red)
    }
    
    func appendNumber(_ text: String) {
        appendText("\(text),", color: .cyan)
    }
    
    func appendString(_ text: String) {
        appendText("\"\(text)\",", color: .blue)
    }
    
    func appendTab(_ n: Int) {
        var tab = ""
        for _ in 0 ..< n {
            tab += "  "
        }
        appendNormal(tab);
    }
    
    func newLine() {
        appendNormal("\n")
    }
    
    func appendText(_ text: String, color: UIColor)  {
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.m80_setTextColor(color)
        attributedText.m80_setFont(UIFont(name: "Menlo", size: 12)!)
        prettyLabel.appendAttributedText(attributedText)
    }

}

