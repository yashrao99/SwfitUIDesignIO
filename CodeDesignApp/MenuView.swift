//
//  MenuView.swift
//  CodeDesignApp
//
//  Created by Yashas Rao on 4/19/20.
//  Copyright © 2020 CodeDesign. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack {
            // Embedding inner menu in V-stack with spacer pushes the menu to the bottom
            Spacer()
            // 16 pixels between each element in the Menu v-stack
            VStack(spacing: 16) {
                Text("Meng - 28% complete")
                    .font(.caption)
                // The code below creates the progress bar
                // This is an example of building views without having a stupid amount of container views
                // the first frame is the current progress bar, the second frame is the full progress bar. The third frame is the outer most container view.
                Color.white
                    // sets frame for inner-most view
                    .frame(width: 38, height: 6)
                    .cornerRadius(3)
                    .frame(width: 130, height: 6, alignment: .leading)
                    .background(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.08))
                    .cornerRadius(3)
                    // Puts 16 pixels between inner two containers and the outermost
                    .padding()
                    // Sets frame for outer-most view
                    .frame(width: 150, height: 24)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(12)
                MenuRow(title: "Account", icon: "gear")
                MenuRow(title: "Billing", icon: "creditcard")
                MenuRow(title: "Sign out", icon: "person.crop.circle")
            }
                // Stretches the width to the edges
            .frame(maxWidth: .infinity)
                // Sets the height at 300
            .frame(height: 300)
                // bg Color with gradient
                // Cutomizable gradient views, you can init Color(Color_literal) which provides you the color-picker. The color picker can be used with direct Hex/RGB as done below to pick colors
                .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), Color(#colorLiteral(red: 0.8705882353, green: 0.8941176471, blue: 0.9450980392, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                // This clips the corners of the view creating the smooth rounded corners
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                // Adds the drop-shadow
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
                // This padding actually shrinks the view by 30 pixels on each side after the corner radius trimming/shadow view
            .padding(.horizontal, 30)
                // This overlay just acts as a UIView on top of this existing screen
                // it creates the image, sets eqal width and height and then clips which forms the circle and then the offset bumps it up to the top of the view
            .overlay(
                Image("Avatar")
                .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                .clipShape(Circle())
                    .offset(y: -159)
            )
        }
        .padding(.bottom, 30)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

// Extracted this component for resuability. the two init vars sets the title and the image based on SFProImages
struct MenuRow: View {
    var title: String
    var icon: String
    
    var body: some View {
        // 16 pixels between the image and the text
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .light))
                .imageScale(.large)
                .frame(width: 32, height: 32)
                .foregroundColor(Color(#colorLiteral(red: 0.662745098, green: 0.7333333333, blue: 0.831372549, alpha: 1)))
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .default))
                .frame(width: 120, alignment: .leading)
        }
    }
}
