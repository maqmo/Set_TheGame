//
//  ViewController.swift
//  Set_Game
//
//  Created by Mohamed Albgal on 9/21/19.
//  Copyright © 2019 Mohamed Albgal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    /*
     before the page loads, set the drawings for each card image to be whatever the card's properties are
    color, number, shape, shading
     */
    var cardMap :[UIButton:Card] = Dictionary<UIButton, Card>()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var screenCards = game.deal(NumberofCards: 24)!
        for btn in cardUIButtons {
            let card = screenCards.popLast()!
            renderCardDetails(basedOn: card, withButton: btn)
        }
    }
    var game :Set_TheGame = Set_TheGame()
    var selected :[Card] = [Card](){
        didSet{
            if selected.count == 3 {
                checkSelected()
            }
        }
    }
    var score :Int = 0{
        didSet{
            //notify the view that the score changed
        }
    }
    
    func checkSelected(){
        assert(selected.count == 3)
        let setFound = game.determineIfSetFound(withCards: selected)
        if setFound{
            score += 1
            //'turn off' the card
            //replace those 3 cards with 3 more, potentially
        }else if score > 0 {
            score -= 1
            //should those cards still be highlighted and should the view's rep of the selected change?
        }
    }
    //use a dictionary to map uibuttons to cards, that will make reassignment easy
    @IBAction func paint3MoreCards(_ sender: Any) {
        //if clicked deal 3 more cards
        if let newCards = game.deal(NumberofCards: 3){
            print(newCards.count)
            //loop through cards, if hidden, replace
        }
    }
    
    func renderCardDetails(basedOn card:Card, withButton btn:UIButton) {
        var shape :String
        var color :UIColor
        //assign a shape string
        switch card.shape{
            case .circle: shape = "⬤"
            case.square: shape = "⏹"
            case.triangle: shape = "▲"
        }
        //assign a UIColor based on the enum
        switch card.color{
            case .red: color = UIColor.red
            case .green: color = UIColor.green
            case .purple: color = UIColor.purple
        }
        
        //repeat the shape 'count' number of times
        assert(Int(card.count.rawValue) != nil)
        let shapeRepeat = Int(card.count.rawValue)!
        
        if shapeRepeat == 3{
           shape = shape + shape + shape
        }else if shapeRepeat == 2{
            shape += shape
        }
        
        //make the attributed string
        //btn.setTitle(shape, for: UIControl.State.normal)
        let attrs: [NSAttributedString.Key:Any] = [.strokeWidth: 7.0, .strokeColor:color]
        //now create the NSAttrString object and give it the attr var as a param
        let attributedString = NSAttributedString(string: shape, attributes: attrs)
        //now assign the last let-var to the attrText property of our UI Button
        btn.setAttributedTitle(attributedString, for: UIControl.State.normal)
        
        }
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardUIButtons: [UIButton]!;
    @IBAction func selectCard(_ sender: UIButton) {
        //change the view of the card, highlight
        let cardIndex = cardUIButtons.firstIndex(of: sender)!
        selected += [game.dealtCards[cardIndex]]
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
    
    
 
 */

