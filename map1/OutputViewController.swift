//
//  OutputViewController.swift
//  map1
//
//  Created by WEB on 2020/09/02.
//  Copyright © 2020 WEB. All rights reserved.
//

import UIKit

class OutputViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    
    // この変数に値が格納される
    var outputValue : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        //入力された内容を代入
        textLabel.text = outputValue
        
    }
    
    
    //戻るボタン
    @IBAction func ReturnButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
