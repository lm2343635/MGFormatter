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
        
        request(formatterView)
    }
    
    @IBAction func request(_ sender: FormatterView) {
        guard let url = urlTextField.text else {
            return
        }
        Alamofire.request(url).responseJSON { [weak self] response in
            guard let formatterView = self?.formatterView, let data = response.data else {
                return
            }
            let utf8Text = String(data: data, encoding: .utf8) ?? ""
            formatterView.format(string: utf8Text, style: .jsonDark)
        }
    }
    
}
