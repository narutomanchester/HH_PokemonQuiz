//
//  SettingController.swift
//  Lab_Day01_PokemonQuiz
//
//  Created by mac on 11/20/16.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit

class SettingController : UIViewController {
    @IBOutlet var btnSelectGeneration: [UIButton]!
    var genAfterChoosen = UserDefaults.standard.object(forKey: "genAfterChoosen") as? [Int]
    var count : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        enter()
    }

    func enter() {
        count = 0
        for i in 0..<6 {
            if (genAfterChoosen?[i] == 0 ) {
                btnSelectGeneration[i].alpha = 0.3
            } else {
                btnSelectGeneration[i].alpha = 1
                count += 1
            }
            btnSelectGeneration[i].tag =  100 * 2 + i
        }
    }
    @IBAction func invokeBackHome(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
  
    @IBAction func invokeSelectGenerations(_ sender: UIButton) {
        let btn = self.view.viewWithTag(sender.tag) as! UIButton
        if (btn.alpha == 1)  {
            if (count == 1){
                return
            }
            btn.alpha = 0.3
            count -= 1
            genAfterChoosen?[sender.tag-200] = 0
            UserDefaults.standard.set(genAfterChoosen, forKey: "genAfterChoosen")
        } else {
            genAfterChoosen?[sender.tag-200] = 1
            UserDefaults.standard.set(genAfterChoosen, forKey: "genAfterChoosen")
            btn.alpha = 1
            count += 1
        }
    }
   }
