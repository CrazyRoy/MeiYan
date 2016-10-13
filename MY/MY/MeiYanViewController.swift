//
//  MeiYanViewController.swift
//  MY
//
//  Created by CodeLL on 2016/10/12.
//  Copyright © 2016年 coderLL. All rights reserved.
//

import UIKit
import GPUImage

class MeiYanViewController: UIViewController {

    var videoCamera : GPUImageVideoCamera?  // 视频源
    var captureVideoPreview : UIView!   // 最终预览视图
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 1. 创建视频源
        let videoCamera = GPUImageVideoCamera(sessionPreset: AVCaptureSessionPresetHigh, cameraPosition: AVCaptureDevicePosition.back)
        videoCamera?.outputImageOrientation = UIInterfaceOrientation.portrait
        self.videoCamera = videoCamera
        
        // 2. 创建最终预览视图
        let captureVideoPreview = GPUImageView(frame: UIScreen.main.bounds)
        // 2.1 将预览图插入到根视图中显示
        self.view.insertSubview(captureVideoPreview, at: 0)
        self.captureVideoPreview = captureVideoPreview
        
        // 3. 设置处理链
        self.videoCamera?.addTarget(captureVideoPreview)
        
        // 4. 调用视频源的startCameraCapture方法, 告诉底层将采集到的视频源渲染到GPUImageView上, 然后显示
        self.videoCamera?.startCapture()
    }

    
    // 切换美颜效果
    @IBAction func changeValue(_ sender: UISwitch) {
        
        // 1.移除之前的所有处理链
        self.videoCamera?.removeAllTargets()
        
        if(sender.isOn) {
            
            // 1.创建美颜滤镜
            let beautifyFilter = GPUImageBeautifyFilter()
            
            // 2.设置GPUImage处理链，从数据源 => 滤镜 => 最终界面效果
            self.videoCamera?.addTarget(beautifyFilter)
            beautifyFilter.addTarget(self.captureVideoPreview as! GPUImageInput!)
            
        }else {
            
           // 1.重新设置处理链
            self.videoCamera?.addTarget(self.captureVideoPreview as! GPUImageInput)
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.dismiss(animated: true, completion: nil)
    }
}
