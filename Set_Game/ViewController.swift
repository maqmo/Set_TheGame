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
            paintButton(basedOn: card, withButton: btn)
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
    
    func paintButton(basedOn card:Card, withButton btn:UIButton) {
        var shape :String
        var color :UIColor
        switch card.shape{
            case .circle: shape = "⚪️"
            case.square: shape = "⬜️"
            case.triangle: shape = "▲"
            }
        switch card.color{
        case .red: color = UIColor(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
        }
        
        //RESUME HERE, i was making the attributed string for display and verification purposes only. make the attr string like ive cp pasted from his example code, and make sure it renders correctly, then fix the game logic(the logic should work but get out the bugs, guaranteed to be some, have not tested this!) close!
        btn.setTitle(shape, for: UIControl.State.normal)
        let atrs: [NSAttributedString.Key:Any] = [
            .strokeWidth: 7.0
                .strokeColor:
            ]
        
        
        
        
        
        
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeWidth : 5.0,
            .strokeColor :  #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        ]
        //now create the NSAttrString object and give it the attr var as a param
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        
        //now assign the last let-var to the attrText property of our UI Button
        flipCountLabel.attributedText = attributedString
        
        
        
        
        btn.setAttributedTitle(strAtr, for: <#T##UIControl.State#>)
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

