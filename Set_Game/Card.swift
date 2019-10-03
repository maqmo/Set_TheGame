//
//  Card.swift
//  Set_Game
//
//  Created by Mohamed Albgal on 9/21/19.
//  Copyright © 2019 Mohamed Albgal. All rights reserved.
//

import Foundation

struct Card :Hashable{
    var id :Int
    var matched :Bool
    var color :Set_TheGame.Color
    var shape: Set_TheGame.Shape
    var outline: Set_TheGame.Outline
    var count :Set_TheGame.Count
    private static var cardInvetory = 0
    private static func assignId()->Int{
        cardInvetory += 1
        return cardInvetory
    }
    init(color c:Set_TheGame.Color, shape s:Set_TheGame.Shape, outline o:Set_TheGame.Outline ,count n:Set_TheGame.Count){
        self.id = Card.assignId()
        self.matched = false
        self.color = c
        self.shape = s
        self.outline = o
        self.count = n
    }
    static func ==(lhs:Card, rhs:Card) -> Bool {
        return (lhs.id == rhs.id)
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}



