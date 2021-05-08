//
//  ContentView.swift
//  Memoriza
//
//  Created by Laborit on 14/03/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    // Mark: - Observable to View watch the change inside the Model and reBuild view
   @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        Grid (viewModel.cards) { card in
                CardView(card: card).onTapGesture{
                    withAnimation(.linear(duration: 0.5)) {
                        self.viewModel.choose(card: card)
                    }
                    
                }
                .padding(5)
            }
        .foregroundColor(.purple)
                .padding()
//        MARK: -Reset game with action button
        Button(action: {
            withAnimation(.easeInOut){
                self.viewModel.ResetGame()
            }
        }, label: {Text("New Game")})
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    @State private var animatedBonusRemaining: Double = 0
//    MARK: - AnimationRemaining
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    var body: some View {
        GeometryReader{ geometry in
            if card.isFaceUp || !card.isMatched {
                ZStack {
                    Group{
                        if card.isConsumingBonusTime {
                            Pie(startAngle: Angle.degrees(0-90) , endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockWise: true )
                                .onAppear{
                                    self.startBonusTimeAnimation()
                                }
                        } else {
                            Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockWise: true)
                        }
                    }
                    .padding(5).opacity(0.4)
                    Text(self.card.content)
                        .font(Font.system(size: min(geometry.size.width, geometry.size.height) * fontScaleFactor))
//                        Mark: - Animations
                        .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                        .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
                }
    //            .modifier(Cardify(isFaceUp: card.isFaceUp))
                    .cardify(isFaceUp: card.isFaceUp)
    //                MARK: -ANIMATION WHEN THE CARDS IS MATCHED.
                .transition(AnyTransition.scale)
                        
                }
            
            }
            
        }
        
    }
    
    
    
    //MARK: - Drawing Constants
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
    let fontScaleFactor: CGFloat = 0.65
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
       return EmojiMemoryGameView(viewModel: game );
//        AnotherView();
    }
}
