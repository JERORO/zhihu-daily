//
//  Request.swift
//  知乎日报
//
//  Created by jiahong.chen on 2018/9/2.
//  Copyright © 2018年 jiahong.chen. All rights reserved.
//

import Foundation

class Request {
    
    //发送POST请求NSURLSession
    func POST(originalurl : String,originaldata : String,completion : @escaping (Any,String) -> Void)
    {
        //对请求路径的说明
        //协议头+主机地址+接口名称
        //POST请求需要修改请求方法为POST，并把参数转换为二进制数据设置为请求体
        
        //1.创建会话对象
        let session: URLSession = URLSession.shared
        
        //2.根据会话对象创建task
        
        
        let url: NSURL = NSURL(string: Config().url() + originalurl)!
        
        //3.创建可变的请求对象
        let request: NSMutableURLRequest = NSMutableURLRequest(url: url as URL)
        
        //4.修改请求方法为POST
        request.httpMethod = "POST"
        
        //5.设置请求体
        //request.httpBody = "username=test&password=123".data(using: String.Encoding.utf8)
        request.httpBody = "\(originaldata)".data(using: String.Encoding.utf8)
        
        //6.根据会话对象创建一个Task(发送请求）
        /*
         第一个参数：请求对象
         第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
         data：响应体信息（期望的数据）
         response：响应头信息，主要是对服务器端的描述
         error：错误信息，如果请求失败，则error有值
         */
        let dataTask: URLSessionDataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            if(error == nil){
                //8.解析数据
                //说明：（此处返回的数据是JSON格式的，因此使用NSJSONSerialization进行反序列化处理）
                var dict:NSDictionary? = nil
                
                do {
                    dict  = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.init(rawValue: 0)) as? NSDictionary
                    completion(dict!,"success")
                } catch {
                    completion("","error")
                }
                
            }else{
                completion("","error")
                
            }
            
        }
        //5.执行任务
        dataTask.resume()
        
    }
    
    
}
