//
//  ViewController.swift
//  VideoPlayerSwift
//
//  Created by 满艺网 on 2017/12/28.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func PlayLocalVideo() {
        //let url = Bundle.main.url(forResource: "hubblecast", withExtension: "m4v")//
        let url = Bundle.main.url(forResource: "hubblecast", withExtension: "m4v")
        guard url != nil else {
            print("播放的url有问题")
            return }
        let playBachVC = PlayBackViewController()
        playBachVC.urlStr = url
        navigationController?.pushViewController(playBachVC, animated: true)
    }
    @IBAction func PlayRemoteVideo() {
        //
        let url = URL(string: "http://v4.music.126.net/20171229140027/47f98ad9cf51a5e2b0ac0b3eddc25b42/cloudmusic/MzY2MzE5NzE=/cd79bc26d34713d35a28182199c6fbdc/8a522a4a207b6ef24eb3557fc1af1fc2.mp4")
        guard url != nil else {
            print("播放的url有问题")
            return
        }
        let playBackVC = PlayBackViewController(url!)
        navigationController?.pushViewController(playBackVC, animated: true)
    }
    @IBAction func playRemoteURL() {
        guard let text = textField.text else { return }
        let url = URL(string: text)
        guard url != nil else {
            print("播放的url有问题")
            return
        }
        let playBackVC = PlayBackViewController(url!)
        navigationController?.pushViewController(playBackVC, animated: true)
    }
}

extension ViewController {

}

