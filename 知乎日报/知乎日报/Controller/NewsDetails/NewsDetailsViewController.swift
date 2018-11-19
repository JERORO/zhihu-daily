//
//  NewsDetailsViewController.swift
//  知乎日报
//
//  Created by Yizhe.Zhang on 2018/9/9.
//  Copyright © 2018年 jiahong.chen. All rights reserved.
//

import UIKit
import Kingfisher
import WebKit

class NewsDetailsViewController: UIViewController,WKUIDelegate,WKNavigationDelegate,UIScrollViewDelegate {
    
    var id = "0"
    
    var model = NewsModel()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageSourceLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var imageSourceBgView: UIView!
    
    @IBOutlet weak var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.scrollView.delegate = self
        
        model.details(id: id, completion: { (status) in
            DispatchQueue.main.async {
                self.viewInit()
            }
        })
        
        model.getStoryExtra(id: id) { (status) in
            DispatchQueue.main.async {
                self.loveLabel.text = "\(self.model.storyExtra!.popularity)"
                self.commentLabel.text = "\(self.model.storyExtra!.comments)"
            }
        }
        
        //取消对状态栏的留空
        if #available(iOS 11.0, *) {
            webView.scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        let swipe = UISwipeGestureRecognizer(target:self, action:#selector(close(_:)))
        swipe.direction = .right
        self.view.addGestureRecognizer(swipe)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        openFunc()
    }
    
    @IBOutlet weak var mainImageConstraint: NSLayoutConstraint!
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
        }
        
        mainImageConstraint.constant = -scrollView.contentOffset.y
        
    }
    
    func viewInit() {
        imageSourceBg() //图片来源底色
        titleLabel.text = model.detailsObject!.title
        imageSourceLabel.text = "图片 " + model.detailsObject!.image_source
        let mainimageUrl = URL(string: model.detailsObject!.image)
        mainImageView.kf.indicatorType = .activity
        mainImageView.kf.setImage(with: mainimageUrl)
        
        let html = "<!DOCTYPE html><html><head><meta charset='UTF-8'><link rel='stylesheet' href='\(model.detailsObject!.css[0])'><meta name='viewport' content='width=device-width, initial-scale=1.0'></head>" + model.detailsObject!.body + "</html>"
        
        webView.loadHTMLString(html, baseURL: nil)
        
    }
    
    // MARK: - 底部操作
    //返回
    @IBAction func backBtnTap(_ sender: UIButton) {
        closeFunc()
    }
    //分享
    @IBAction func shareBtnTap(_ sender: UIButton) {
        if model.detailsObject != nil {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: model.detailsObject!.share_url)!, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
                if let url = NSURL(string: model.detailsObject!.share_url)  {
                    UIApplication.shared.openURL(url as URL)
                }
            }
            
        }
    }
    
    @IBOutlet weak var loveLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    //渐变
    func imageSourceBg() {
        
        //定义渐变的颜色（从黄色渐变到橙色）
        let topColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        let buttomColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        let gradientColors = [topColor.cgColor, buttomColor.cgColor]
        
        //创建CAGradientLayer对象并设置参数
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        
        //设置其CAGradientLayer对象的frame，并插入view的layer
        gradientLayer.frame = CGRect(origin:  self.view.frame.origin, size: imageSourceBgView.frame.size)
        imageSourceBgView.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    

    
    //打开函数
    func openFunc() {
       view.center.x = view.center.x + 200
        UIView.animate(withDuration: 0.2, animations: {
            self.view.alpha = 1
            self.view.center.x -= 200
        }) { (status) in
            
        }
    }
    
    //关闭函数
    @objc func close(_ recognizer:UISwipeGestureRecognizer){
        closeFunc()
    }
    
    func closeFunc() {
        UIApplication.shared.statusBarStyle = .default
        UIView.animate(withDuration: 0.2, animations: {
            self.view.alpha = 0
            self.view.center.x += 200
        }, completion: { (status) in
            self.presentingViewController?.dismiss(animated: false, completion: nil)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
