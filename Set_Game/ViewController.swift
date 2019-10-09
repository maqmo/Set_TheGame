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
        cardUIButtons.forEach{$0.isHidden = true}
        let newCards = game.deal(numberOfCards: 12)
        updateViewFromModel(withCards: newCards!)
    }
    var selectedButtons :Set<UIButton> = Set<UIButton>() {
        didSet{
            if selectedButtons.count == 3 {
                handleTrio()
            }
        }
    }
    
    var score :Int = 0 {
        didSet{
            if score < 0 {
                score += 1
            }
            scoreLabel.text = "Score : \(score)"
        }
    }
    
    func handleTrio(){
        assert(selectedButtons.count == 3)
        //get the corresponding cards for the selected buttons using our dict (map to arr and pass to game method)
        let cards :[Card] = selectedButtons.map{buttonToCardMap[$0]!}
        if game.setFound(withTrio: cards){
            score += 1
            for button in selectedButtons{
//                button.toggleHighlight()
                button.unHighlight()
                button.isHidden = true
                buttonToCardMap[button]!.matched = true
                buttonToCardMap[button] = nil
            }
            dealButton.isHidden = false
        }else{
            score -= 1
        }
    }
    
    func resetSelected(){
        for button in selectedButtons{
            button.unHighlight()
        }
        selectedButtons.removeAll()
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
        let attrs: [NSAttributedString.Key:Any] = [.strokeWidth: 12.0, .strokeColor:color]
        //now create the NSAttrString object and give it the attr var as a param
        let attributedString = NSAttributedString(string: shape, attributes: attrs)
        //now assign the last let-var to the attrText property of our UI Button
        btn.setAttributedTitle(attributedString, for: UIControl.State.normal)
        btn.isHidden = false;
        }
    
    func updateViewFromModel(withCards newCards:[Card]) {
        var index = newCards.makeIterator()
        for button in cardUIButtons {
            if buttonToCardMap[button] == nil, let newCard = index.next() {
                buttonToCardMap[button] = newCard
                renderCardDetails(basedOn: newCard, withButton: button)
            }
        }
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardUIButtons: [UIButton] = []
    @IBOutlet weak var dealButton: UIButton!
    @IBAction func deal3(_ sender: UIButton) {
        if let newCards = game.deal(numberOfCards: 3) {
            updateViewFromModel(withCards: newCards)
        }else {
            sender.isHidden = true;
        }
    }
    @IBAction func selectCard(_ sender: UIButton) {
        //if button has been clicked before,
        if selectedButtons.count == 3 {
            resetSelected()
        }
        if selectedButtons.contains(sender), buttonToCardMap[sender]!.matched == false {
            sender.unHighlight()
            selectedButtons.remove(sender)
        }else {
            sender.highlight()
            selectedButtons.insert(sender)
        }
    }
}
//extension UIButton {
//    var isYellow :Bool {
//        return (self.layer.borderColor == UIColor.yellow.cgColor)
//    }
//}
//extension UIButton{
//    func toggleHighlight(){
//        let color = self.isYellow ? UIColor.clear.cgColor: UIColor.yellow.cgColor
//        let width = self.isHighlighted ? 0 : 10
//        self.layer.borderWidth = CGFloat(width)
//        self.layer.borderColor = color
//    }
//}

extension UIButton {
    func highlight() {
        self.layer.borderWidth = CGFloat(8)
        self.layer.borderColor = UIColor.yellow.cgColor
        self.backgroundColor = UIColor.black
    }
    func unHighlight() {
        self.layer.borderWidth = CGFloat(0)
        self.layer.borderColor = UIColor.clear.cgColor
        self.backgroundColor = UIColor.white
    }
}

/*
 TODO:
    fix shading option ??
    fix layout [close, just dive into it
    fix deal 3 more logic + ui
    implement ability to show up to 81 cards (layout / view issue)
 */

