//
//  ViewController.swift
//  Set_Game
//
//  Created by Mohamed Albgal on 9/21/19.
//  Copyright © 2019 Mohamed Albgal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var game :Set_TheGame = Set_TheGame()
    var cardLookUp = Dictionary<UIButton, Int>()
    override func viewWillAppear(_ animated: Bool) {
        //before showing the view, deal and display the dealt card's details on the buttons
        super.viewWillAppear(animated)
        game.deal(NumberofCards: 24)
        updateViewBasedOnModel()
    }
    var highlightedCards = [UIButton](){
        didSet{
            highlightCards()
        }
    }
    var selectedCards :[Card] = [Card]() {
        didSet{
            if selectedCards.count == 3 {
                if highlightedCards.count == 3{
                    inspectSet()
                }else{
                    //unhighlight the cards,
                }
            }
        }
    }
    var score :Int = 0 {
        didSet{
            //notify the view that the score changed
        }
    }
    
    func inspectSet(){
        /*
         if set found: update 3. only deal 3 more if the user asks for it
         if no set found
         */
    }
    func renderCardDetails(basedOn card:Card, withButton btn:UIButton) {
        var shape :String
        var color :UIColor
        //assign a shape string
        switch card.shape{
            case .circle: shape = "◎"
            case.square: shape = "❒"
            case.triangle: shape = "▲"
        }
        //assign a UIColor based on the enum
        switch card.color{
            case .red: color = UIColor.red
            case .green: color = UIColor.green
            case .purple: color = UIColor.purple
        }
        //repeat the shape string 'count' times
        switch card.count {
        case .one: break;
        case.two: shape += shape
        case .three: shape = shape + shape + shape
        }
        
        //make the attributed string
        //btn.setTitle(shape, for: UIControl.State.normal)
        let attrs: [NSAttributedString.Key:Any] = [.strokeWidth: 12.0, .strokeColor:color]
        //now create the NSAttrString object and give it the attr var as a param
        let attributedString = NSAttributedString(string: shape, attributes: attrs)
        //now assign the last let-var to the attrText property of our UI Button
        btn.setAttributedTitle(attributedString, for: UIControl.State.normal)
        
        }
    
    //redraw the cards on the screen based on the model's cardsDealt array where each card is not matched
    func setFound() -> Bool{
        //tally up the features for each card in 'selected'
        var featureTally = [Set<String>(), Set<String>(), Set<String>(), Set<String>()]
        for card in selectedCards{
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
    
    func updateViewBasedOnModel(){
        for index in 0...cardUIButtons!.count - 1 {
            let modelCard = game.cardsInPlay[index]
            let uiCard = cardUIButtons[index]
            cardLookUp[uiCard] = modelCard.id
            renderCardDetails(basedOn:modelCard, withButton: uiCard )
        }
    }
    
    func highlightCards(){
        /*
            for card in highlightedCards{
            let cardIndex = cardUIButtons.firstindex(card)
            modify the look of cardUIButtons[cardIndex] to become highlighted
         }
         */
    }
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardUIButtons: [UIButton]!;
    @IBAction func render3MoreCards(_ sender: Any) {
        //if clicked deal 3 more cards, rerender
    }
    @IBAction func selectCard(_ sender: UIButton) {
        //change the view of the card, highlight
        let cardId = cardLookUp[sender]!
        let modelCard = game.cardsInPlay.filter{$0.id == cardId}
        assert(modelCard.count == 1)
        selectedCards.append(modelCard[0])
    }
}


/*
 
 before a new game can be selected:
    set all the cards (24) from the deck of 81
    show 12/24
        how to temporarily hide a card?
    set the deal button to only deal when:
        cards in play are < 24
 
 new game
 
 click a cardUIButton
    
    view:
        that card now highlighted as a selection
    model:
        see which card was clicked
        add to selected array, or see if set found
    
    
 
 
 TODO:
    fix shading option ??
    fix layout [close, just dive into it
    fix deal 3 more logic + ui
    implement 'selection' highlighting
    implement ability to show up to 81 cards (layout / view issue)
 */

