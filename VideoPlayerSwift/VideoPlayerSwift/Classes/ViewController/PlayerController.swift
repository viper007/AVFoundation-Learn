//
//  PlayerController.swift
//  VideoPlayerSwift
//
//  Created by 满艺网 on 2017/12/28.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerController: NSObject {
    var timer : Timer?
    fileprivate var asset : AVURLAsset?
    var displayView : PlayerlayerView = PlayerlayerView()
    var player : AVPlayer? {
        didSet {
            removeTimer()
        }
    }
    fileprivate var playerItem : AVPlayerItem?
    convenience init(_ urlString : URL) {
       self.init()
       asset = AVURLAsset(url: urlString)
       playerItem = AVPlayerItem(asset: asset!)
       player = AVPlayer(playerItem: playerItem)
       displayView.player = player!
       addObservers()
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status" {
//            let status = change![NSKeyValueChangeKey.newKey] as? AVPlayerItemStatus
//            print(status)
            if playerItem?.status == AVPlayerItemStatus.readyToPlay {
                readyToPlay()
            } else {
                if playerItem?.status == AVPlayerItemStatus.failed {
                   print("加载资源失败")
                } else {
                   print("加载资源未知")
                }
            }
        }
    }
    //时间
    var duration : Float64 = 0
    var currentTime : Float64 = 0
}

extension PlayerController {
    fileprivate func readyToPlay() {
        player?.play()
        addTimer()
        addNotifications()
    }
}

extension PlayerController {

    fileprivate func addTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateInfo), userInfo: nil, repeats: true)
    }

    fileprivate func removeTimer() {
         timer?.invalidate()
         timer = nil
         playerItem?.removeObserver(self, forKeyPath: "status")
         NotificationCenter.default.removeObserver(self)
    }

    @objc fileprivate func updateInfo() {
        let duration_let = player?.currentItem?.duration
        if CMTIME_IS_VALID(duration_let!) {
            duration = CMTimeGetSeconds(duration_let!)
        } else {return}
        let current_duration = player?.currentItem?.currentTime()
        if CMTIME_IS_VALID(current_duration!) {
            currentTime = CMTimeGetSeconds(current_duration!)
        } else {return}
        displayView.progress = Float(currentTime / duration)
        displayView.currentTIme = String(format: "%02d", Int(currentTime)/60) + ":" + String(format: "%02d", Int(currentTime)%60)
        displayView.duration = String(format: "%02d", Int(duration)/60) + ":" + String(format: "%02d", Int(duration)%60)
    }
}

extension PlayerController {
    fileprivate func addObservers() {
        playerItem?.addObserver(self, forKeyPath: "status", options: [.new], context: nil)
    }
    fileprivate func addNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(playerReadyToPlay), name:NSNotification.Name(rawValue: AVPlayerReadyToPlay), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(playerPaused), name:NSNotification.Name(rawValue: AVPlayerPaused), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(playerSeekTime(_ :)), name: NSNotification.Name(rawValue : AVPlayerTimeSlide), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleInterruption(_ :)), name: NSNotification.Name.AVAudioSessionInterruption, object: AVAudioSession.sharedInstance())
    }

    @objc func playerReadyToPlay() {
        let currentTime : Float64 = CMTimeGetSeconds((player?.currentItem?.currentTime())!)
        if currentTime == duration {
            let timeScale : Int32 = (player?.currentItem?.currentTime().timescale)!
            player?.currentItem?.seek(to: CMTimeMakeWithSeconds(0, timeScale), completionHandler: { (finish) in
                self.player?.play()
                return
            })
        }
        if player?.rate == 0 {
           player?.play()
        }
    }
    @objc func playerPaused() {
        player?.pause()
    }
    @objc func playerSeekTime(_ note : NSNotification) {
        let value = note.object as! Float
        let timeScale : Int32 = (player?.currentItem?.currentTime().timescale)!
        let timeValue = Float64(Float(self.duration)*value)
        player?.currentItem?.seek(to: CMTimeMakeWithSeconds(timeValue, timeScale), completionHandler: { (finish) in

        })
    }
    @objc fileprivate func handleInterruption(_ note : NSNotification) {

    }
}
