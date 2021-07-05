//
//  ViewController.swift
//  jankeng
//
//  Created by WEB on 2020/06/26.
//  Copyright © 2020 HAL. All rights reserved.
//

import UIKit
import AVFoundation


class JankengViewController: UIViewController, AVAudioPlayerDelegate {
    
    
    var jankenponPlayer:AVAudioPlayer!
    var newAnswerNumber:UInt32 = 0 //じゃんけん番号
    var oldAnswerNumber:UInt32 = 2 //じゃんけん番号保持用
    
    //じゃんけん画像
    @IBOutlet weak var answerImageView: UIImageView!
    //じゃんけんテキスト
    @IBOutlet weak var answerLabel: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let audioPath = Bundle.main.path(forResource: "jankenpon", ofType:"mp3")!
        let jankenponUrl = URL(fileURLWithPath: audioPath)
        do{
        jankenponPlayer = try AVAudioPlayer(contentsOf: jankenponUrl) } catch let error as NSError {
        print(error.code)
        }
        
        jankenponPlayer.delegate = self
    }
    
    
    
    //戻るボタン
    @IBAction func ReturnButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    //ボタンが押されたら
    @IBAction func btn(_ sender: Any) {
        jankenponPlayer.play()
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        //音がなり終わってからの処理
        //画像を設定
        //じゃんけん処理
        //被り回避
        newAnswerNumber = arc4random_uniform(3)
        while(newAnswerNumber == oldAnswerNumber) {
            newAnswerNumber = arc4random_uniform(3)
        }
        oldAnswerNumber = newAnswerNumber
        
        
        switch newAnswerNumber {
        case 0:
            answerImageView.image=UIImage(named:"gu")
            answerLabel.text="グー"
        case 1:
            answerImageView.image=UIImage(named:"choki")
            answerLabel.text="チョキ"
        case 2:
            answerImageView.image=UIImage(named:"pa")
            answerLabel.text="パー"
        default:
            break
        }
        
    }

    
}


