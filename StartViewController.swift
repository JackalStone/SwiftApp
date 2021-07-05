//
//  StartViewController.swift
//  map1
//
//  Created by WEB on 2020/09/02.
//  Copyright © 2020 WEB. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var inputText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    // segueが動作することをViewControllerに通知するメソッド
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // segueのIDを確認して特定のsegueのときのみ動作
    if segue.identifier == "toOutputViewController" {
    // 呼び出し先のViewControllerを取得
    let next = segue.destination as? OutputViewController
        //呼び出し先の変数に値を渡す(outputValue)
        next?.outputValue = self.inputText.text
        //next?.delegate=self
    } }
    

}
