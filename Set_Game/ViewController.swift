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
    var buttonToCardMap = Dictionary<UIButton, Card>()
    override func viewWillAppear(_ animated: Bool) {
        //before showing the view, deal and display the model's dealt card's details on the buttons
        super.viewWillAppear(animated)
        game.deal(NumberofCards: 24)
        var newCards = game.cardsInPlay
        for button in cardUIButtons{
            let newCard = newCards.popLast()!
            buttonToCardMap[button] = newCard
            renderCardDetails(basedOn: newCard, withButton: button)
        }
        game.cardsInPlay = newCards
    }
    var selectedButtons :[UIButton] = [UIButton]() {
        didSet{
            assert(selectedButtons.count < 4)
            if selectedButtons.count == 3 {
                inspectSet()
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
         if set found, hide the buttons, increment score, turn off highlight, set card to matched, break button to card mapping
         */
        assert(selectedButtons.count == 3)
        if setFound(){
            score += 1
            for button in selectedButtons{
                button.toggleHighlight()
                button.isHidden = true
                buttonToCardMap[button]!.matched = true
                buttonToCardMap[button] = nil
            }
        }else{
            score -= 1
            for button in selectedButtons{
                button.toggleHighlight()
            }
        }
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
        let cards :[Card] = selectedButtons.map{buttonToCardMap[$0]!}
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
    
    func updateViewFromModel(){
        
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardUIButtons: [UIButton]!
    @IBAction func render3MoreCards(_ sender: Any) {
        //if clicked deal 3 more cards, rerender
    }
    @IBAction func selectCard(_ sender: UIButton) {
        selectedButtons.append(sender)
    }
}

extension UIButton{
    func toggleHighlight(){
        let color = self.isHighlighted ? UIColor.clear.cgColor: UIColor.systemYellow.cgColor
        let width = self.isHighlighted ? 0 : 10
        self.isHighlighted = !self.isHighlighted
        self.layer.borderWidth = CGFloat(width)
        self.layer.borderColor = color
    }
}

/*
 TODO:
    fix shading option ??
    fix layout [close, just dive into it
    fix deal 3 more logic + ui
    implement ability to show up to 81 cards (layout / view issue)
 */

