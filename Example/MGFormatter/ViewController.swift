//
//  ViewController.swift
//  MGFormatter
//
//  Created by lm2343635 on 08/13/2017.
//  Copyright (c) 2017 lm2343635. All rights reserved.
//

import UIKit
import MGFormatter

let string = "{\"result\":{\"rev\":39,\"update\":true,\"categories\":[{\"cid\":\"000000005bce908d015bd18e59460006\",\"createAt\":1493869418822,\"enable\":true,\"active\":true,\"identifier\":\"Appliances\",\"name\":{\"en\":\"Appliances\",\"zh\":\"家电\",\"ja\":\"家電\"},\"icon\":\"/files/category/14d0c75b-b5b6-4461-9d26-39015e374332.png\",\"rev\":39,\"priority\":0},{\"cid\":\"000000005bd1f743015bd2252d460001\",\"createAt\":1493879303494,\"enable\":true,\"active\":true,\"identifier\":\"Home\",\"name\":{\"en\":\"Home\",\"zh\":\"家居\",\"ja\":\"ホーム\"},\"icon\":\"/files/category/5a6a517a-28d0-490a-878a-b02c2153f5f6.png\",\"rev\":38,\"priority\":1},{\"cid\":\"000000005bd1f743015bd40996590003\",\"createAt\":1493911049816,\"enable\":true,\"active\":true,\"identifier\":\"Electronics\",\"name\":{\"en\":\"Electronics\",\"zh\":\"数码\",\"ja\":\"デジタル\"},\"icon\":\"/files/category/82fefe2d-8f6b-4a03-b9cb-5a52c48498b4.png\",\"rev\":37,\"priority\":2},{\"cid\":\"000000005bd1f743015bd40a41d60004\",\"createAt\":1493911093718,\"enable\":true,\"active\":true,\"identifier\":\"Books\",\"name\":{\"en\":\"Books\",\"zh\":\"图书\",\"ja\":\"本\"},\"icon\":\"/files/category/33bc9774-0a39-4365-adde-247db5291375.png\",\"rev\":36,\"priority\":3},{\"cid\":\"000000005bd1f743015bd40bff830005\",\"createAt\":1493911207811,\"enable\":true,\"active\":true,\"identifier\":\"Cycling\",\"name\":{\"en\":\"Cycling\",\"zh\":\"自行车\",\"ja\":\"自転車\"},\"icon\":\"/files/category/df6068ff-c40c-457d-921f-d1929091cd14.png\",\"rev\":35,\"priority\":4},{\"cid\":\"000000005bd1f743015bd40d078b0006\",\"createAt\":1493911275402,\"enable\":true,\"active\":true,\"identifier\":\"Automotive\",\"name\":{\"en\":\"Automotive\",\"zh\":\"汽车\",\"ja\":\"車\"},\"icon\":\"/files/category/90baad57-19d3-4bd4-b00f-d13453ecfd14.png\",\"rev\":34,\"priority\":5},{\"cid\":\"000000005bd1f743015bd40dae390007\",\"createAt\":1493911318073,\"enable\":true,\"active\":true,\"identifier\":\"Games\",\"name\":{\"en\":\"Games\",\"zh\":\"游戏\",\"ja\":\"ゲーム\"},\"icon\":\"/files/category/d2a4046b-eb8a-42b8-8f83-20796c106e8a.png\",\"rev\":33,\"priority\":6},{\"cid\":\"000000005bd1f743015bd416763c0008\",\"createAt\":1493911893564,\"enable\":true,\"active\":true,\"identifier\":\"Others\",\"name\":{\"en\":\"Others\",\"zh\":\"其他\",\"ja\":\"他\"},\"icon\":\"/files/category/2430f7a5-2e07-4a21-824c-8e23bbcb0efa.png\",\"rev\":32,\"priority\":999}]},\"status\":200}"

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let formatterView = FormatterView(string,
                                          color: FormatterColor.light,
                                          frame: CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 50))
        view.addSubview(formatterView)
    }
    
}

