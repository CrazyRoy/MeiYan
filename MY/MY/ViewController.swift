//
//  ViewController.swift
//  MY
//
//  Created by CodeLL on 2016/10/8.
//  Copyright © 2016年 coderLL. All rights reserved.
//

import UIKit
import GPUImage

// MARK:- 系统回调方法
class ViewController: UIViewController {
    
    // MARK:- 控件属性
    
    @IBOutlet weak var mmBtn: UIButton!
    
    @IBOutlet weak var myBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mmBtn.alpha = 0
        self.myBtn.alpha = 0
        self.mmBtn.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        self.myBtn.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        
        // 弹性动画
        UIView.animate(withDuration: 0.25, delay: 1.0, usingSpringWithDamping: 1, initialSpringVelocity: 10, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            
            self.mmBtn.alpha = 1
            self.myBtn.alpha = 1
            self.mmBtn.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.myBtn.transform = CGAffineTransform(scaleX: 1, y: 1)
            
            }, completion: nil)
    }
    
    // MARK:- 点击磨皮、美白
    @IBAction func tagMMBtn(_ sender: UIButton) {
        
        let vc = GPUViewController()
        
        self.present(vc, animated: true, completion: nil)
    }
    
    // MARK:- 点击美颜实战
    @IBAction func tagMYBtn(_ sender: UIButton) {
        
    }
    
}

// MARK:- 私有方法
extension ViewController {
    
}

