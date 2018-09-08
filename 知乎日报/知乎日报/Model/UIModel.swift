//
//  UIModel.swift
//  知乎日报
//
//  Created by Yizhe.Zhang on 2018/9/8.
//  Copyright © 2018年 jiahong.chen. All rights reserved.
//

import Foundation

import UIKit

extension UIView{
    @IBInspectable var boardwidth: CGFloat {//边框宽度
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor {//边框颜色
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {//边框圆角
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = newValue > 0 //裁边
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {//阴影位移
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    @IBInspectable var shadowRadius: CGFloat {//阴影半径
        get {
            return self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
        }
    }
    @IBInspectable var shadowOpacity: Float {//阴影不透明度
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
    @IBInspectable var shadowColor: UIColor {//阴影颜色
        get {
            return UIColor.black
        }
        set {
            self.layer.shadowColor = newValue.cgColor
        }
    }
    
    
}

@IBDesignable class DIYButton: UIButton {//方法可视化
    
}

@IBDesignable class DIYTextField: UITextField {//方法可视化
    
}

@IBDesignable class DIYView: UIView {//方法可视化
    
}

@IBDesignable class DIYImage: UIImage {//方法可视化
    
}

@IBDesignable class DIYImageView: UIImageView {//方法可视化
    
}
@IBDesignable class DIYLabel: UILabel {//方法可视化
    
}
