//
//  Pokemon.swift
//  Lab_Day01_PokemonQuiz
//
//  Created by mac on 11/20/16.
//  Copyright © 2016 mac. All rights reserved.
//

import Foundation

class Pokemon {
    var Id : Int?
    var name : String?
    var tag : String?
    var gen : Int?
    var img : String?
    var color : String?
    init(Id : Int , name : String , tag : String , gen : Int , img : String , color : String) {
        self.Id = Id
        self.name = name
        self.tag = tag
        self.gen = gen
        self.img = img
        self.color = color
    }
}
