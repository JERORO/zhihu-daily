//
//  MainModel.swift
//  知乎日报
//
//  Created by Yizhe.Zhang on 2018/9/8.
//  Copyright © 2018年 jiahong.chen. All rights reserved.
//

import Foundation
import SwiftyJSON
import FTIndicator

class MainModel {
    
    var topStoriesArr : [top_stories] = []
    
    func top(completion : @escaping (Bool) -> Void){
        topStoriesArr = []
        Request().GET(originalurl: "/4/news/latest", originaldata: "") { (content, status) in
            if status {
                let json = JSON(content as Any)
                for (_,subJson):(String, JSON) in json["top_stories"] {
                    self.topStoriesArr.append(top_stories(id: subJson["id"].stringValue, title: subJson["title"].stringValue, ga_prefix: subJson["ga_prefix"].stringValue, image: subJson["image"].stringValue, type: subJson["type"].intValue))
                }
                completion(true)
            }else{
                FTIndicator.showError(withMessage: "请求错误")
                 completion(false)
            }
        }
    }
}

struct top_stories {
    var id : String
    var title : String
    var ga_prefix : String
    var image : String
    var type : Int
}
