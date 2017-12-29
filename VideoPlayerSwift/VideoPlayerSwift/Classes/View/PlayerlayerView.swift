//
//  PlayerlayerView.swift
//  VideoPlayerSwift
//
//  Created by 满艺网 on 2017/12/28.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerlayerView: UIView {

    var duration : String = "" {
        didSet {
           overLay?.endLabel.text = duration
        }
    }
    var currentTIme : String = "" {
        didSet {
           overLay?.startLabel.text = currentTIme
        }
    }
    var progress : Float = 0.0 {
        didSet {
            overLay?.progressView.value = progress
        }
    }
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    var player : AVPlayer? {
        didSet {
            let layer = self.layer as! AVPlayerLayer
            layer.videoGravity = AVLayerVideoGravity.resizeAspect
            layer.player = player
        }
    }

    var overLay : OverLayView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        overLay = Bundle.main.loadNibNamed("OverLayView", owner: nil, options: nil)?.first as? OverLayView
        addSubview(overLay!)
        overLay?.snp.makeConstraints({ (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(64)
        })
        addNotifications()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func addNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(playerPlayToEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }

    @objc fileprivate func playerPlayToEnd() {
          print("播放结束")
          overLay?.playButton.isSelected = true
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
