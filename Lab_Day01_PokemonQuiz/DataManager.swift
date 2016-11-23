//
//  DataManager.swift
//  Lab_Day01_PokemonQuiz
//
//  Created by mac on 11/20/16.
//  Copyright © 2016 mac. All rights reserved.
//

import Foundation

class DataManager {
    static var defaultManager = DataManager()
    
    let kDatabaseName = "pokemon"
    let kDatabaseExtension = "db"
    var database: FMDatabase!
    
    //var pokemons = Array(repeating: Pokemon(Id: 1, name: "", tag: "", gen: 1, img: "", color: ""!), count: 1000)
    
    init() {
        self.database = FMDatabase(path: self.getDatabaseFolderPath())
    }
    
    func getDatabaseFolderPath() -> String {
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return documentPath + "/" + kDatabaseName + "." + kDatabaseExtension
    }
    
    //1. Copy database
    
    
    func copyDatabaseIfNeed() {
        let bundlePath = Bundle.main.path(forResource: "pokemon", ofType: "db")
        
        let documentPath = self.getDatabaseFolderPath()
//        print(documentPath)
//        print("documentPath : ",documentPath)
        if !FileManager.default.fileExists(atPath: documentPath) {
            do {
//                print(bundlePath)
//                print(documentPath)
                try FileManager.default.copyItem(atPath: bundlePath!, toPath: documentPath)
                print("Completed")
            } catch  {
                (error)
            }
        }
    }
    
    
    func selectPokemon() -> [Pokemon] {
        var pokemons : [Pokemon] = []
        database?.open()
        let genAfterChoosen = UserDefaults.standard.object(forKey: "genAfterChoosen") as? [Int]
        var selectQuery = "SELECT * FROM pokemon Where"
        var count = 0
        
        for var indexGenAfterChoosen in 0..<(genAfterChoosen?.count)!{
            if (genAfterChoosen?[indexGenAfterChoosen] == 1){
                count += 1
                indexGenAfterChoosen += 1
                if (count > 1) {
                    selectQuery += " or gen = "
                } else {
                    selectQuery += " gen = "
                }
                selectQuery += (String(indexGenAfterChoosen))
            }
        }
       // count = 0
        do {
            let result =  try database?.executeQuery(selectQuery, values: nil)
            
            while (result?.next())!{
                //count += 1
                let pikachuId = (Int)((result?.int(forColumn: "Id"))!)
                let pikachuName = result?.string(forColumn: "name")
                let pikachuTag = result?.string(forColumn: "tag")
                let pikachuGen = Int((result?.int(forColumn: "gen"))!)
                let pikachuImg = result?.string(forColumn: "img")
                let pikachuColor = result?.string(forColumn: "color")
                let pokemon = Pokemon(Id: pikachuId, name: pikachuName!, tag: pikachuTag!, gen: pikachuGen, img: pikachuImg!, color: pikachuColor!)
                pokemons.append(pokemon)
               // print(pikachuGen)
            }
//            print(count)
        
           // print("Insert Successfully")
        } catch  {
            print("Insert Fail", error)
        }
        
        database?.close()
        return pokemons
    }
    
    func radInt(n : Int) -> Int {
        let rad = Int(arc4random_uniform(UInt32(n)))
        return rad
    }
    
    
    var checkImgPoke = Array(repeating: true, count: 1000)
    
    func radPokemonName() -> Int {
        var pokemons = selectPokemon()
        let x = radInt(n: pokemons.count)
        return x
    }
    
    func randImagePokemon() -> Int {
        var pokemons = selectPokemon()

        var x = radInt(n: pokemons.count)
        while (checkImgPoke[x]) == false{
            x = radInt(n: pokemons.count)
        }
        return x
    }
        
}
