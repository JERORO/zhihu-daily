//
//  ViewController.swift
//  知乎日报
//
//  Created by jiahong.chen on 2018/9/2.
//  Copyright © 2018年 jiahong.chen. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var model = MainModel()

    @IBOutlet weak var topStoriesView: UIScrollView!
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var bottomLIneVIew: UIView!
    @IBOutlet weak var bottomLabel: UILabel!
    
    //拉刷新控制器
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topStories()
        
        initData()
        // Do any additional setup after loading the view, typically from a nib.
    
        //添加刷新
        refreshControl.addTarget(self, action: #selector(ViewController.initData),
                                 for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新数据")
        tableView.addSubview(refreshControl)
        
        //单击监听
        let tapSingle=UITapGestureRecognizer(target:self,action:#selector(tapSingleDid))
        tapSingle.numberOfTapsRequired=1
        tapSingle.numberOfTouchesRequired=1
        self.topStoriesView.addGestureRecognizer(tapSingle)

    }
    

    
    //请求数据
    var dataRequest = false
    @objc func initData() {
        if dataRequest {
            return
        }
        dataRequest = true
        refreshControl.attributedTitle = NSAttributedString(string: "数据加载中......")
        ActivityIndicator.startAnimating()
        bottomLabel.alpha = 0
        bottomLIneVIew.alpha = 0
        
        model.topStoriesArr = []
        model.storiesArr = []
        tableView.reloadData()
        for view in topStoriesView.subviews {
            view.removeFromSuperview()
        }
        
        model.main { (status) in
            if status == true {
                DispatchQueue.main.async {
                    self.topStories()
                    self.tableView.reloadData()
                }
            }
            
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.ActivityIndicator.stopAnimating()
                self.bottomLabel.alpha = 1
                self.bottomLIneVIew.alpha = 1
            }
            self.dataRequest = false
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
        let number = Int(topStoriesView.contentOffset.x / self.view.frame.width)
        let storyboard = UIStoryboard(name: "NewsDetails", bundle: nil)
        let newVC = storyboard.instantiateViewController(withIdentifier: "NewsDetailsPage") as! NewsDetailsViewController
        newVC.id = self.model.topStoriesArr[number].id
        self.present(newVC, animated: false, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.storiesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contentCell", for: indexPath) as! ContentTableViewCell
        
        cell.titleLabel.text = model.storiesArr[indexPath.row].title
        cell.contentLabel.text = model.storiesArr[indexPath.row].title
        
        let imageUrl = URL(string: model.storiesArr[indexPath.row].images[0] as! String)
        cell.mainImageView.kf.indicatorType = .activity
        cell.mainImageView.kf.setImage(with: imageUrl)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "NewsDetails", bundle: nil)
        let newVC = storyboard.instantiateViewController(withIdentifier: "NewsDetailsPage") as! NewsDetailsViewController
        newVC.id = self.model.storiesArr[indexPath.row].id
        
        self.present(newVC, animated: false, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

