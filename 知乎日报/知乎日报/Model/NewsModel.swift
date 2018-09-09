//
//  NewsModel.swift
//  知乎日报
//
//  Created by Yizhe.Zhang on 2018/9/9.
//  Copyright © 2018年 jiahong.chen. All rights reserved.
//

import Foundation
import SwiftyJSON
import FTIndicator

class NewsModel {
    
    var detailsObject : newsDetails? = nil

    //内容详情
    func details(id : String,completion : @escaping (Bool) -> Void){

        Request().GET(originalurl: "/4/news/\(id)", originaldata: "") { (content, status) in
            if status {
                let json = JSON(content as Any)

                self.detailsObject = newsDetails(id: json["id"].stringValue, title: json["title"].stringValue, body: json["body"].stringValue, image: json["image"].stringValue, image_source: json["image_source"].stringValue, recommenders: json["recommenders"].stringValue, ga_prefix: json["ga_prefix"].stringValue, type: json["type"].intValue, share_url: json["share_url"].stringValue, css: json["css"].arrayObject as! [String], js: json["js"].arrayObject as! [String])
                completion(true)
            }else{
                FTIndicator.showError(withMessage: "请求错误")
                completion(false)
            }
        }
    }
    
    var storyExtra : story_extra? = nil
    
    //点赞评论数量
    func getStoryExtra(id : String,completion : @escaping (Bool) -> Void){
        Request().GET(originalurl: "/4/story-extra/\(id)", originaldata: "") { (content, status) in
            if status {
                let json = JSON(content as Any)
                
                self.storyExtra = story_extra(long_comments: json["long_comments"].intValue, popularity: json["popularity"].intValue, short_comments: json["short_comments"].intValue, comments: json["comments"].intValue)
                completion(true)
            }else{
                FTIndicator.showError(withMessage: "请求错误")
                completion(false)
            }
        }
    }
}

struct newsDetails {
    var id : String
    var title : String
    var body : String
    var image : String
    var image_source : String
    var recommenders : String //这篇文章的推荐者
    var ga_prefix : String
//    var section : Any
    var type : Int
    var share_url : String
    var css : [String]
    var js : [String]
}

struct story_extra {
    var long_comments : Int
    var popularity : Int
    var short_comments : Int
    var comments : Int
}
