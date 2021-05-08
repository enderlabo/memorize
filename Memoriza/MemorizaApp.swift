//
//  MemorizaApp.swift
//  Memoriza
//
//  Created by Laborit on 14/03/21.
//

import SwiftUI

@main
struct MemorizaApp: App {
   
    var body: some Scene {
        let game = EmojiMemoryGame()
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
