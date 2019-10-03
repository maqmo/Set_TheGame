//
//  SetGame.swift
//  Set_Game
//
//  Created by Mohamed Albgal on 9/21/19.
//  Copyright © 2019 Mohamed Albgal. All rights reserved.
//

import Foundation

struct Set_TheGame{
    private var cardSet = Set<Card>()
    private var dealtCards = [Card]()
    var cardsInPlay :[Card]{
        get{
            return dealtCards.filter{!$0.matched}
        }
    }
    init(){
        cardSet = makeDeck()
        assert(cardSet.count >= 81)
    }
    mutating func deal(NumberofCards num:Int){
        assert(cardSet.count >= num)
        var cards = [Card]()
        for _ in 1...num{
            cards.append((cardSet.popFirst()!))
        }
        dealtCards += cards
    }
    func makeDeck() -> Set<Card>{
        var deck = Set<Card>()
        for s in Shape.allCases{
            for c in Color.allCases{
                for o in Outline.allCases{
                    for n in Count.allCases{
                        deck.insert(Card(color: c, shape: s, outline: o, count:  n))
                    }
                }
            }
        }
        assert(deck.count >= 81)
        return deck
    }
    public enum Shape: String, CaseIterable {
           case circle, square, triangle
       }
       public enum Color: String,CaseIterable {
           case red, green, purple
       }
       public enum Outline: String,CaseIterable {
           case solid, striped, squiggle
       }
       public enum Count: String ,CaseIterable {
           case one, two, three
       }
}

/*
 Set defined as: each feature category either match or are unique
 They all have the same number or have three different numbers.
 They all have the same shape or have three different shapes.
 They all have the same shading or have three different shadings.
 They all have the same color or have three different colors
 */
