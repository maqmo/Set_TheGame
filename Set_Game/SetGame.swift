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
    }
    
    mutating func deal(numberOfCards num:Int) -> [Card]?{
        assert(cardSet.count >= num)
        var cards = [Card]()
        for _ in 1...num{
            if let newCard = cardSet.randomElement(){
                cards.append(newCard)
            }else{
                cards = []
            }
        }
         dealtCards += cards
        if cards.count == 0{
            return nil
        }
        return cards
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
        return deck
    }
    
    func setFound(withTrio cards: [Card]) -> Bool{
           //tally up the features for each card in 'selected'
           var featureTally = [Set<String>(), Set<String>(), Set<String>(), Set<String>()]
           for card in cards{
            featureTally[0].insert(card.color.rawValue)
               featureTally[1].insert(card.shape.rawValue)
               featureTally[2].insert(card.outline.rawValue)
               featureTally[3].insert(card.count.rawValue)
           }
           for feature in featureTally {
               let countedFeatures = feature.count
               assert(countedFeatures < 4)
               if (countedFeatures == 2) {
                   //if found 1 or 3 of any feature for each card, thats a winning set, finding 2 means the set is invalid
                   return false
               }
           }
           return true
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
