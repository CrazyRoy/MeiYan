//
//  GPUViewController.swift
//  MY
//
//  Created by CodeLL on 2016/10/12.
//  Copyright © 2016年 coderLL. All rights reserved.
//

import UIKit
import GPUImage

class GPUViewController: UIViewController {
    
    var videoCamera : GPUImageVideoCamera!
    
    var bilateralFilter : GPUImageBilateralFilter?  // 磨皮滤镜
    var brightnessFilter : GPUImageBrightnessFilter?    // 美白滤镜
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        // 1. 创建视频源
        // SessionPreset:屏幕的分辨率， AVCaptureSessionPresetHight会自适应高分辨率
        // cameraPosition:摄像头方向
        let videoCamera = GPUImageVideoCamera(sessionPreset: AVCaptureSessionPresetHigh, cameraPosition: AVCaptureDevicePosition.back)
        videoCamera?.outputImageOrientation = UIInterfaceOrientation.portrait
        self.videoCamera = videoCamera
        
        // 2. 创建最终预览view
        let caputureVideoPreview = GPUImageView(frame: UIScreen.main.bounds)
        self.view.insertSubview(caputureVideoPreview, at: 0)
        
        // 3. 创建滤镜： 磨皮，美白， 组合滤镜
        let groupFilter = GPUImageFilterGroup() // 组合滤镜
        
        // 3.1 磨皮滤镜
        let bilateralFilter = GPUImageBilateralFilter()
        //        groupFilter.addTarget(bilateralFilter)
        self.bilateralFilter = bilateralFilter
        
        // 3.2 美白滤镜
        let brightnessFilter = GPUImageBrightnessFilter()
        //        groupFilter.addTarget(brightnessFilter)
        self.brightnessFilter = brightnessFilter
        
        // 3.3 设置滤镜组链
        bilateralFilter.addTarget(brightnessFilter) // 设置滤镜效果组的相互依赖
        groupFilter.initialFilters = [bilateralFilter]; // 设置最初的滤镜效果
        groupFilter.terminalFilter = brightnessFilter;
        
        // 4. 设置GPUImag响应链，从数据源 => 滤镜 => 最终界面效果
        self.videoCamera.addTarget(groupFilter)
        groupFilter.addTarget(caputureVideoPreview)
        
        // 5. 开始采集视频
        self.videoCamera.startCapture()
        // 必须调用startCapture，底层才会把采集到的视频源渲染到GPUImageView中，就能显示额
        
    }

    // MARK:- 美白
    @IBAction func brightnessFilter(_ sender: UISlider) {
        self.brightnessFilter?.brightness = CGFloat(sender.value)
    }
    
    // MARK:- 磨皮
    @IBAction func bilateralFilter(_ sender: UISlider) {
    
        // 值越小，磨皮效果越好
        let maxValue : CGFloat = 10
        self.bilateralFilter?.distanceNormalizationFactor = (maxValue - CGFloat(sender.value))
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.dismiss(animated: true, completion: nil)
    }
}
