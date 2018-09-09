//
//  MyViewController.swift
//  知乎日报
//
//  Created by Yizhe.Zhang on 2018/9/8.
//  Copyright © 2018年 jiahong.chen. All rights reserved.
//

import UIKit
import Kingfisher

class TopStoriesViewController: UIViewController {

    var number:Int!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var imageUrlString = ""
    
    override func viewDidLoad(){

    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewInit()
    }

    func viewInit() {
        
        let imageUrl = URL(string: imageUrlString)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: imageUrl)
        
        mainView.cornerRadius = 5
        mainView.clipsToBounds = true
        mainView.layer.shadowColor = UIColor.gray.cgColor
        mainView.layer.shadowOpacity = 0.4
        mainView.layer.shadowOffset = CGSize(width: 0, height: 2)
        mainView.layer.shadowRadius = 5
        mainView.layer.masksToBounds = false
        
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
