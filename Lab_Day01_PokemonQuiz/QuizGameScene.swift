                     //
//  QuizGameScene.swift
//  Lab_Day01_PokemonQuiz
//
//  Created by mac on 11/18/16.
//  Copyright © 2016 mac. All rights reserved.
//

import UIKit

class QuizGameScene : UIViewController  {

    @IBOutlet weak var progressClockView: RPCircularProgress!
    @IBOutlet var btn: [UIButton]!
    @IBOutlet weak var imgViewGameScene: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var pokemonView: UIView!
    var score = 0;

    let dataManager = DataManager()
    var pokemons = [Pokemon]()
    var tagOfTrueAns = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataManager.defaultManager.copyDatabaseIfNeed()
        pokemons = DataManager.defaultManager.selectPokemon()
        
        //set Start Score = 0
        self.scoreLabel.text = "0"
        
        initBtn()
        setupProgress()
        progressRunFollowTime()
        enter()
    }
    
    func progressRunFollowTime(){
        DispatchQueue.main.async {
            self.progressClockView.updateProgress(1, animated: true, initialDelay: 0, duration: 10, completion: {
                UserDefaults.standard.set(self.score, forKey: "score")
                self.setHighScore()
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(600), execute: {
                    
                    self.navigationController?.popViewController(animated: true)
                })
                
            })
        }
    }
    
    func setHighScore(){
        
    }
    
    func initBtn() {
        for i in 0..<4 {
            btn[i].layer.cornerRadius = 20
            btn[i].tag = 100 + i
        }
    }
    
    func setupProgress() {
        progressClockView.trackTintColor = UIColor.gray
        progressClockView.roundedCorners = false
        progressClockView.clockwiseProgress = true
        progressClockView.progressTintColor = UIColor.white
        progressClockView.thicknessRatio = 1.1
        progressClockView.innerTintColor = UIColor.green
       // progressClockView.progress = 1.1
    }
    
    func enter()  {
     
        //set for True Pokemon
        var truePokemonId = Int(arc4random_uniform(UInt32(self.pokemons.count))) // id of right pokemon
 
        imgViewGameScene.image = UIImage(named: pokemons[truePokemonId].img!) // img of this pokemon
        self.imgViewGameScene.image = self.imgViewGameScene.image?.withRenderingMode(.alwaysTemplate) // hide this img
        self.imgViewGameScene.tintColor = UIColor.black                                               // hide this img
        
        var trueIndexBtn = (Int)(arc4random_uniform(4))
        btn[trueIndexBtn].setTitle(pokemons[truePokemonId].name, for: .normal)
        tagOfTrueAns = btn[trueIndexBtn].tag
        
        //set Background Color follow true Pokemon
        backgroundView.backgroundColor = UIColor().hexStringToUIColor(hex: self.pokemons[truePokemonId].color!)
        
        
        // remainPokemon
        var remainPokemon = pokemons
        remainPokemon.remove(at: truePokemonId)
        
        //set Answer in Button
        for btnIndex in 0..<4{
            if (btnIndex != trueIndexBtn) {
                var remainPokemonId = Int(arc4random_uniform(UInt32(remainPokemon.count)))
                btn[btnIndex].setTitle(remainPokemon[remainPokemonId].name, for: .normal)
                remainPokemon.remove(at: remainPokemonId)
            }
            btn[btnIndex].backgroundColor = UIColor.white
        }
     
    }
    
 
    @IBAction func invokeBackToHome(_ sender: Any) {
        UserDefaults.standard.set(0, forKey: "score")
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func invokeBtnTapped(_ sender: UIButton) {
        
        let btnRight = self.view.viewWithTag(self.tagOfTrueAns) as! UIButton
        btnRight.backgroundColor = UIColor.green
        
        if sender.tag != self.tagOfTrueAns{
            let btnWrong = self.view.viewWithTag(sender.tag) as! UIButton
            btnWrong.backgroundColor = UIColor.gray
        } else {
            self.score += 1
            self.scoreLabel.text = (String(self.score))
        }

        
        //show img of pokemon
        UIView.transition(with: self.pokemonView, duration: 0.2, options: .transitionFlipFromRight, animations: {
            self.imgViewGameScene.image = self.imgViewGameScene.image?.withRenderingMode(.alwaysOriginal)
        }) { (complete) in
            
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(600), execute: {
   
            self.enter()
        })
    }
 
}
