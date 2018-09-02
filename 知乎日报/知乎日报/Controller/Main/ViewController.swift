//
//  ViewController.swift
//  知乎日报
//
//  Created by jiahong.chen on 2018/9/2.
//  Copyright © 2018年 jiahong.chen. All rights reserved.
//

import UIKit
import FTIndicator
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //请求数据
    func initData() {
        Request().GET(originalurl: "/4/news/latest", originaldata: "") { (content, status) in
            if status {
                let json = JSON(content as Any)
                print(json["top_stories"])
            }else{
                FTIndicator.showError(withMessage: "请求错误")
            }
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

