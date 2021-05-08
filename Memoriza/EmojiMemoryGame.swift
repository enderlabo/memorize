//
//  EmojiMemoryGame.swift
//  Memoriza
//
//  Created by Laborit on 14/03/21.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    //MARK: published to ViewModel/Model to listen the change inside the Model
    //MARK: only set by MemoryGame and other just watch de class.
   @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
   private static func createMemoryGame() -> MemoryGame<String>  {
        let emojis: Array<String> = ["👻","🎃","🕷", "🐶", "🦇", "🐷","🪳","🦂","🪲","🐙","🐝","🦋","🐌","🐮"]
        return MemoryGame<String> (numberOfPaisOfCards: emojis.count) { pairIndex in
            return emojis[pairIndex]
        }
    }
    

    //MARK: -Access to the Model
    var cards: Array<MemoryGame<String>.Card>{
        model.cards
    }
    
    //MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card){
        model.choose(card: card)
    }
    //MARK: -Create new MemoryGame /reset all Card
    func ResetGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
