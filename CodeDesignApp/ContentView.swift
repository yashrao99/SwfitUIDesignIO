//
//  ContentView.swift
//  CodeDesignApp
//
//  Created by Yashas Rao on 4/18/20.
//  Copyright © 2020 CodeDesign. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var show = false
    @State var viewState = CGSize.zero
    @State var showCard = false
    @State var bottomState = CGSize.zero
    @State var showFull = false
    
    var body: some View {
        ZStack {
            // The certificates/background image component
            TitleView()
                // Adds blur if the cards are shown
                .blur(radius: show ? 20 : 0)
                // Adds opacity if cards are showh
                .opacity(showCard ? 0.4 : 1)
                // if we are showing the card, offset should be 200 pixels off the screen
                .offset(y: showCard ? -200 : 0)
                // Delays this offset animatio by 100 ms
                .animation(
                    Animation
                        .default
                        .delay(0.1)
            )
            // The furthest-most card in the view
            BackCardView()
                // changes frame based on showCard status
                .frame(width: showCard ? 300 : 340, height: 220)
                // When cards are shown, switches image with other view to make the slide-out animation make sense
                .background(show ? Color("card3") : Color("card4"))
                // round corners with the shadow
                .cornerRadius(20)
                .shadow(radius: 10)
                // When cards are being dragged around, animate this card out
                .offset(x: 0, y: show ? -400 : -40)
                .offset(x: viewState.width, y: viewState.height)
                // if bottomCard is shown, then animate the card out
                .offset(y: showCard ? -180 : 0)
                // scale the card when animating out to show depth effect
                .scaleEffect(showCard ? 1 : 0.9)
                // Rotation effects to keep the wallet-like style when cards are collapsed
                .rotationEffect(.degrees(show ? 0 : 10))
                .rotationEffect(.degrees(showCard ? -10 : 0))
                .rotation3DEffect(.degrees(showCard ? 0 : 10), axis: (x: 10.0, y: 0.0, z: 0.0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.5))
            
            // Middle-card. See above comments for break-down of functionality
            BackCardView()
                .frame(width: 340, height: 220)
                .background(show ? Color("card4") : Color("card3"))
                .cornerRadius(20)
                .shadow(radius: 10)
                .offset(x: 0, y: show ? -200 : -20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -140 : 0)
                .scaleEffect(showCard ? 1 : 0.95)
                .rotationEffect(.degrees(show ? 0 : 5))
                .rotationEffect(.degrees(showCard ? -5 : 0))
                .rotation3DEffect(.degrees(showCard ? 0 : 5), axis: (x: 10.0, y: 0.0, z: 0.0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.3))

            CardView()
                // The main card with the certificate
                .frame(width: showCard ? 375 : 340.0, height: 220.0)
                .background(Color.black)
                // Creates smooth rounded corners
                .clipShape(RoundedRectangle(cornerRadius: showCard ? 30 : 20, style: .continuous))
                .shadow(radius: 20)
                .offset(x: viewState.width, y: viewState.height)
                // When bottom card shows up, bump card up from center by 100
                .offset(y: showCard ? -100 : 0)
                .blendMode(.hardLight)
                // Adds spring animation
                .animation(.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0))
                // If tapped, show the card
                .onTapGesture {
                    self.showCard.toggle()
            }
            .gesture(
                // if being dragged, translate the cardViews, and show flips the animation on the back cards to expand out
                DragGesture().onChanged { value in
                    self.viewState = value.translation
                    self.show = true
                }
                    // After dragging is complete, animate it back to the original state and flip the state back to false
                .onEnded { value in
                    self.viewState = .zero
                    self.show = false
                }
            )
            BottomCardView()
                // If showCard, animate it up. Else ensure it's off the screen
                .offset(x: 0, y: showCard ? 360 : 1000)
                .offset(y: bottomState.height)
                // If card is up, and then the cardView is being dragged, blur this screen
                .blur(radius: show ? 20 : 0)
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
                .gesture(
                    // Added drag gesture
                    DragGesture().onChanged { value in
                        // changed the bottom state value as translation occurs
                        self.bottomState = value.translation
                        // If we are in the showFull state, adding the -300 normalizes our translation gesture so it doesn't automatically reset to the center
                        if self.showFull {
                            self.bottomState.height += -300
                        }
                        // if we have the bottomCard fully visible, we don't want to see the bottom of the card, so if we try to pull more than the full amount, cap the offset at -300
                        if self.bottomState.height < -300 {
                            self.bottomState.height = -300
                        }
                    }
                    .onEnded { value in
                        // If we are dragging the bottom card down more than 50 pixels, act as if we are dismissing the card and set the state
                        if self.bottomState.height > 50 {
                            self.showCard = false
                        }
                        // These 2 conditions are telling us to either animate the card out to showFull if we have moved more than 100 pixels up from the original state, or if we have dragged less than 50 pixels down from the showFull state
                        if (self.bottomState.height < -100 && !self.showFull) || (self.bottomState.height < -250 && self.showFull) {
                            self.bottomState.height = -300
                            self.showFull = true
                        } else {
                            // If neither of these conditions are it, reset to original position and update the showFull state
                            self.bottomState = .zero
                            self.showFull = false
                        }
                    }
                )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    var body: some View {
        VStack {
            HStack {
                // This v-stack creates the UIDesign/Certificate
                VStack(alignment: .leading) {
                    Text("UI Design")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Text("Certificate")
                        .foregroundColor(Color("accent"))
                }
                // The spacer pushes the image and the text to opposites sides of parent view
                Spacer()
                Image("Logo1")
            }
            // Puts padding of 20 on each side from parent view
            .padding(.horizontal, 20)
            // 20 pixels anchor from top
            .padding(.top, 20)
            // This spacer separates logo/certificate from background image on card
            Spacer()
            // adds the background card and sets image logic
            Image("Card1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 110, alignment: .top)
        }
    }
}

struct BackCardView: View {
    var body: some View {
        VStack {
            Spacer()
        }
    }
}

struct TitleView: View {
    var body: some View {
        // VStack holds the header title and the background image below it
        VStack {
            HStack {
                Text("Certificates")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                // This spacer pushes the text to the left instead of being centered
                Spacer()
            }
            // adds 16 pxls from each side padding
            .padding()
            Image("Background1")
            // This spacer pushes title to top, image to bottom
            Spacer()
        }
    }
}

struct BottomCardView: View {
    var body: some View {
        // V-stack holding the various views of this component, 20 pixels between
        VStack(spacing: 20) {
            // This creates the small rectangle at the top of the slider view
            Rectangle()
                .frame(width: 40, height: 5)
                .cornerRadius(3)
                .opacity(0.1)
            // 16t pixels below that, creates the actual text
            Text("This certificate is proof that Yashas Rao has achieved the UI Design course with approval from a Design+Code instructor")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .lineSpacing(4)
            // This spacer pushes the text to the top
            Spacer()
        }
            // adds padding from top/sides
        .padding(.top, 8)
        .padding(.horizontal, 20)
            // stretches view to the full width of screen
        .frame(maxWidth: .infinity)
            
        .background(Color.white)
        .cornerRadius(30)
        .shadow(radius: 20)
    }
}
