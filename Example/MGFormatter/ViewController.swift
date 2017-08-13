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

let string = "{\"result\":{\"messages\":[{\"mid\":\"000000005cb02e93015cb12a3676007b\",\"createAt\":1497620952694,\"updateAt\":1497620952694,\"seq\":22,\"title\":\"Desk\",\"price\":1000,\"cover\":\"/files/picture/000000005cb02e93015cb12a3676007b/357cf653-e9b5-442c-a038-d933c47eaebf.jpg\",\"favorites\":2,\"enable\":true,\"cid\":\"000000005bce908d015bd18e59460006\"},{\"mid\":\"000000005cb02e93015cb0d5a51b0073\",\"createAt\":1497615410458,\"updateAt\":1497615410458,\"seq\":21,\"title\":\"Panasonic Hair dryer\",\"price\":1000,\"cover\":\"/files/picture/000000005cb02e93015cb0d5a51b0073/bc5921fa-ee0b-474b-bf54-f10206249f4c.jpg\",\"favorites\":4,\"enable\":true,\"cid\":\"000000005bce908d015bd18e59460006\"},{\"mid\":\"000000005cb02e93015cb0cdcc540051\",\"createAt\":1497614896212,\"updateAt\":1497614896212,\"seq\":15,\"title\":\"yuasa扇風機\",\"price\":1500,\"cover\":\"/files/picture/000000005cb02e93015cb0cdcc540051/f010c0c7-9431-4ba3-baa1-81440c2033e9.jpg\",\"favorites\":2,\"enable\":true,\"cid\":\"000000005bce908d015bd18e59460006\"},{\"mid\":\"000000005cb02e93015cb0c3df4f003b\",\"createAt\":1497614245709,\"updateAt\":1497614245709,\"seq\":12,\"title\":\"電子レンジ\",\"price\":5000,\"cover\":\"/files/picture/000000005cb02e93015cb0c3df4f003b/73c5fc14-6373-4450-ae40-b7da62e54c2d.jpg\",\"favorites\":1,\"enable\":true,\"cid\":\"000000005bce908d015bd18e59460006\"},{\"mid\":\"000000005cb02e93015cb0bfb43c0029\",\"createAt\":1497613972540,\"updateAt\":1497613972540,\"seq\":7,\"title\":\"Window air conditioner\",\"price\":8000,\"cover\":\"/files/picture/000000005cb02e93015cb0bfb43c0029/510d1a22-1f80-4c46-9198-7bfae6b892b6.jpg\",\"favorites\":1,\"enable\":true,\"cid\":\"000000005bce908d015bd18e59460006\"},{\"mid\":\"000000005cb02e93015cb0be48380022\",\"createAt\":1497613879352,\"updateAt\":1497613879352,\"seq\":6,\"title\":\"Sanyo refrigerator\",\"price\":4000,\"cover\":\"/files/picture/000000005cb02e93015cb0be48380022/7edc55ae-551e-49a8-ba40-5f5e99e6a632.jpg\",\"favorites\":1,\"enable\":true,\"cid\":\"000000005bce908d015bd18e59460006\"},{\"mid\":\"000000005cb02e93015cb09afa750005\",\"createAt\":1497611565668,\"updateAt\":1497611565668,\"seq\":1,\"title\":\"A good lamp \",\"price\":1000,\"cover\":\"/files/picture/000000005cb02e93015cb09afa750005/51bcb4a5-5a9a-4e87-95f0-9a7b14de55a5.jpg\",\"favorites\":3,\"enable\":true,\"cid\":\"000000005bce908d015bd18e59460006\"}]},\"status\":200,\"type\":\"application/json\",\"time\":2.56}"

class ViewController: UIViewController {

    let prettyLabel = M80AttributedLabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = string.data(using: .utf8) {
            let json = JSON(data: data)
            appendNormal("{\n")
            for (key,subJson):(String, JSON) in json {
                tab(1)
                appendAttribute(key)
                if let string = subJson.string {
                    appendString(string)
                } else if let double = subJson.double {
                    if double.truncatingRemainder(dividingBy: 1) == 0 {
                        appendNumber(String(format: "%.0f", double))
                    } else {
                        appendNumber(String(double))
                    }
                }
                
                newLine()
            }
            appendNormal("}")
            
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
    
    func appendNormal(_ text: String) {
        appendText(text, color: .black)
    }
    
    func appendAttribute(_ text: String) {
        appendText("\"\(text)\": ", color: .red)
    }
    
    func appendNumber(_ text: String) {
        appendText(text, color: .cyan)
    }
    
    func appendString(_ text: String) {
        appendText("\"\(text)\"", color: .blue)
    }
    
    func tab(_ n: Int) {
        appendNormal("  ");
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

