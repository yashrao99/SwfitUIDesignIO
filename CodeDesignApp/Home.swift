//
//  Home.swift
//  CodeDesignApp
//
//  Created by Yashas Rao on 4/19/20.
//  Copyright © 2020 CodeDesign. All rights reserved.
//

import SwiftUI

struct Home: View {
    @State var showProfile = false
    @State var viewState = CGSize.zero
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                // This ignores safearelayoutguide and stretches to all edges
                .edgesIgnoringSafeArea(.all)

            HomeView(showProfile: $showProfile)
            // Since background ignores safe area, need to manually add the top spacing for the status bar
                .padding(.top, 44)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
                // If profile is shown, then bump this view up 450 pixels
                .offset(y: showProfile ? -450 : 0)
                // Adds some 3D effect when it animates up. We can use the translation value to accomplish this
                .rotation3DEffect(.degrees(showProfile ? Double(viewState.height/10) - 10 : 0), axis: (x: 10.0, y: 0.0, z: 0.0))
                // Scales when profile slides up
                .scaleEffect(showProfile ? 0.9 : 1)
                // Adds bounce animation to profile sliding up
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                // Fills everything, why we added the padding above
                .edgesIgnoringSafeArea(.all)
            // Adds our menu view
            MenuView()
                // COOL TRICK HERE - Added essentially a transparent veil which is interactable. This will show up when the Menu view is visible giving a `tap outside view to dismiss` feel
                .background(Color.black.opacity(0.001))
                // Hide it if showProfile not toggled
                .offset(y: showProfile ? 0 : screen.height)
                // Animate the view if we are dragging around
                .offset(y: viewState.height)
                // add animation
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                // tapping on menu should dismiss it
                .onTapGesture {
                    self.showProfile.toggle()
            }
            .gesture(
                // translation gesture
                DragGesture().onChanged { value in
                    self.viewState = value.translation
                }
            .onEnded{ value in
                // If we drag the menu view down more than 50, swipe to dismiss
                if self.viewState.height > 50 {
                    self.showProfile.toggle()
                }
                // reset after drag is complete
                self.viewState = .zero
            }
            )
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct AvatarView: View {
    // Since we extracted the avatar button into it's own component, it loses the state from the parent class. Therefore, we declare this state as a binding in this extracted component which will become a required param when initializing it in the parentView
    @Binding var showProfile: Bool
    
    var body: some View {
        Button(action: {
            // toggle the showProfile state when pressed
            self.showProfile.toggle()
        }) {
            // Open the brackets here to start editing the imageView of the UIButton
            Image("Avatar")
                .renderingMode(.original)
                .resizable()
                .frame(width: 36, height: 36)
                .clipShape(Circle())
        }
    }
}

let screen = UIScreen.main.bounds
