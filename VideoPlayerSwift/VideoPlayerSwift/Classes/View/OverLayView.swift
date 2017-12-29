//
//  OverLayView.swift
//  VideoPlayerSwift
//
//  Created by 满艺网 on 2017/12/28.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

import UIKit

class OverLayView: UIView {
    
    //添加滑动条
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var progressView: UISlider!
    //加载对应的Xib的时候对应的其他的方法不要实现
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    //MARK: - 播放和暂停
    @IBAction func PlayOrPause(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        let postName = sender.isSelected ? AVPlayerPaused : AVPlayerReadyToPlay
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: postName), object: nil)
    }
    
    @IBAction func timeSliderAction(_ sender: UISlider) {
        //改变对应的时间
        NotificationCenter.default.post(name: NSNotification.Name(rawValue : AVPlayerTimeSlide), object: sender.value)
    }
    
}
