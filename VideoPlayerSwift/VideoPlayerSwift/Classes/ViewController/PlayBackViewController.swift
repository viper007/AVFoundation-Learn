//
//  PlayBackViewController.swift
//  VideoPlayerSwift
//
//  Created by 满艺网 on 2017/12/28.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

import UIKit
import SnapKit

class PlayBackViewController : UIViewController {
    convenience init(_ url : URL) {
        self.init()
        self.urlStr = url
    }
    var urlStr : URL?
    fileprivate var player : PlayerController?
    override func viewDidLoad() {
        super.viewDidLoad()
        readyToPlay()
    }

    func readyToPlay() {
        view.backgroundColor = UIColor.white
        self.edgesForExtendedLayout = UIRectEdge.bottom //从导航栏下下面开始计算
        self.extendedLayoutIncludesOpaqueBars = false
        self.modalPresentationCapturesStatusBarAppearance = false
        player = PlayerController(urlStr!)
        let displayView = player?.displayView
        view.addSubview(displayView!)
        displayView?.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
    }

    deinit {
//        player?.player?.currentItem?.cancelPendingSeeks()
//        player?.player?.currentItem?.asset.cancelLoading()
        player?.player = nil
    }
}
