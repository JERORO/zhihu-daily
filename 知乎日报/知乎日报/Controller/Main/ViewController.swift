//
//  ViewController.swift
//  知乎日报
//
//  Created by jiahong.chen on 2018/9/2.
//  Copyright © 2018年 jiahong.chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var model = MainModel()

    @IBOutlet weak var topStoriesView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topStories()
        
        initData()
        // Do any additional setup after loading the view, typically from a nib.
        
        //单击监听
        let tapSingle=UITapGestureRecognizer(target:self,action:#selector(tapSingleDid))
        tapSingle.numberOfTapsRequired=1
        tapSingle.numberOfTouchesRequired=1
        self.topStoriesView.addGestureRecognizer(tapSingle)

    }
    

    
    //请求数据
    func initData() {
        model.top { (status) in
            if status == true {
//                print(self.model.topStoriesArr)
                DispatchQueue.main.async {
                    self.topStories()
                }
            }
        }
        
    }
    
    //topStories
    func topStories() {
        let numOfPages = self.model.topStoriesArr.count
        
        topStoriesView.contentSize = CGSize(width: self.view.frame.width*CGFloat(numOfPages), height: 220)
        //添加子页面
        for i in 0..<numOfPages{
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let TopStories = storyboard.instantiateViewController(withIdentifier: "TopStoriesView") as? TopStoriesViewController {
//                let TopStories = TopStoriesViewController(number:(i+1))
                TopStories.number = i+1
                TopStories.view.frame = CGRect(x:Int(self.view.frame.width)*i, y:0,
                                               width:Int(self.view.frame.width), height:220)
                TopStories.imageUrlString = self.model.topStoriesArr[i].image
                TopStories.pageControl.numberOfPages = numOfPages
                TopStories.pageControl.currentPage = i
                TopStories.titleLabel.text = self.model.topStoriesArr[i].title
                topStoriesView.addSubview(TopStories.view)
            }
            
            
        }
        
    }
    
    //跳转
    @objc func tapSingleDid(){
       print(Int(topStoriesView.contentOffset.x / self.view.frame.width))
        
        let storyboard = UIStoryboard(name: "NewsDetails", bundle: nil)
//        if
//        {
            let vc = storyboard.instantiateViewController(withIdentifier: "NewsDetailsPage")
            // 获取其Navigation Controller
            let navigationController = UINavigationController(rootViewController: vc)
            self.present(navigationController, animated: true, completion: { () -> Void in
                
            })
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

