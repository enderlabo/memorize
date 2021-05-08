//
//  MemoryGame.swift
//  Memoriza
//
//  Created by Laborit on 14/03/21.
//

import Foundation

struct MemoryGame <CardContent> where CardContent: Equatable {
   private(set) var cards: Array<Card>
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }
            .only
        }
        set {
            for index in cards.indices {
                    cards[index].isFaceUp = index == newValue
               
            }
        }
    }
    //MARK: Choose the card
   mutating func choose(card: Card){
        print("Card choosen: \(card)")
    if let choosenIndex = cards.firstIndex(matching: card), !cards[choosenIndex].isFaceUp,
       !cards[choosenIndex].isMatched {
        if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
            if cards[choosenIndex].content  == cards[potentialMatchIndex].content {
                cards[choosenIndex].isMatched = true
                cards[potentialMatchIndex].isMatched = true
            }
        } else {
            indexOfTheOneAndOnlyFaceUpCard = choosenIndex
        }
        
        self.cards[choosenIndex].isFaceUp = true
        
        }
    }
    
    
    //MARK: function to validated the numbers cards
    init(numberOfPaisOfCards: Int, cardContentFactory: (Int) -> CardContent){
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPaisOfCards{
            let content = cardContentFactory(pairIndex)
            cards.append(Card( content: content, id: pairIndex*2 ))
            cards.append(Card( content: content, id: pairIndex*2+1 ))
        }
        //Mark: randon cards.
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        
        
        
//        MARK: Animation TimeCircle.
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var content: CardContent
        var id: Int
        
        //the last time this card was turned face up (and is still face up )
        var bonusTimeLimit: TimeInterval = 6
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        var lastFaceUpDate: Date?
        var pastFaceUpTime: TimeInterval = 0
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit: 0
        }
        
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startUsingBonusTime( ) {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
    
}



