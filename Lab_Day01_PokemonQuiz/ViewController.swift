//
//  ViewController.swift
//  Lab_Day01_PokemonQuiz
//
//  Created by mac on 11/18/16.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var genAfterChoosen = Array(repeating: 1, count: 6)
    
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblHighScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        UserDefaults.standard.set(genAfterChoosen, forKey: "genAfterChoosen")
        UserDefaults.standard.set(0, forKey: "score")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setHighScore()
    }

    func setHighScore(){
        
        if (UserDefaults.standard.object(forKey: "highscore") == nil){
            UserDefaults.standard.set(0, forKey: "highscore")
            let score = UserDefaults.standard.object(forKey: "score") as? Int
            
            lblScore.text = "0"
            lblHighScore.text = "High Score"
        } else {
            if let highscore = UserDefaults.standard.object(forKey: "highscore") as? Int{
                if let score = UserDefaults.standard.object(forKey: "score") as? Int {
                    
                    if (highscore < score){
                        lblScore.text = String(score)
                        lblHighScore.text = "New High Score"
                        UserDefaults.standard.set(score, forKey: "highscore")
                    } else {
                        if (score <= highscore){
                            lblScore.text = String(score)
                            if (highscore != 0){
                                lblHighScore.text = "High Score : " + String(highscore)
                            } else{
                                lblHighScore.text = "High Score"
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    @IBAction func invokeSettingGame(_ sender: Any) {
        let settingController = self.storyboard?.instantiateViewController(withIdentifier: "SettingController") as! SettingController
        
        self.navigationController?.pushViewController(settingController, animated: true)
        
    }

    @IBAction func invokeBtnPlayGame(_ sender: Any) {
        let quizGameSceneController = self.storyboard?.instantiateViewController(withIdentifier: "QuizGameController") as! QuizGameScene
        
        
        self.navigationController?.pushViewController(quizGameSceneController, animated: true)
        
    }
}

