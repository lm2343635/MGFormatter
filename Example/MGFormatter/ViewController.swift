//
//  ViewController.swift
//  MGFormatter
//
//  Created by lm2343635 on 08/13/2017.
//  Copyright (c) 2017 lm2343635. All rights reserved.
//

import UIKit
import MGFormatter
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var formatterView: FormatterView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func request(_ sender: Any) {
        Alamofire.request(urlTextField.text!).responseJSON { (response) in
            let utf8Text = String(data: response.data!, encoding: .utf8) ?? ""
            self.formatterView.format(utf8Text, color: .light)
        }
    }
    
}

