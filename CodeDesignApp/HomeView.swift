//
//  HomeView.swift
//  CodeDesignApp
//
//  Created by Yashas Rao on 4/19/20.
//  Copyright © 2020 CodeDesign. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @Binding var showProfile: Bool

    var body: some View {
        VStack {
            // This HStack is the header at the top
            HStack {
                Text("Watching")
                    .font(.system(size: 28, weight: .bold))
                // spacer pushes the title and the avatar image to opposite sides
                Spacer()
                AvatarView(showProfile: $showProfile)
            }
            // Adds teh 16 pixels on all 4 sides
            .padding(.horizontal)
            // Adds additional 14 to the leading anchor (30 total)
            .padding(.leading, 14)
            // Adds additional 30 to the top anchor (46 total)
            .padding(.top, 30)
            
            // SCROLL VIEW, setting the direction on the init is NOT the scrolling direction
            ScrollView(.horizontal, showsIndicators: false) {
                // Embedding the items in either or HStack or VStack will determine the scroll direction
                HStack(spacing: 30) {
                    // cmd + click -> repeat creates simple, editable for loop to repeat UI elements
                    ForEach(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                        SectionView()
                    }
                }
                // Adds 30 pixels from all sides of the HStack
                .padding(30)
                // Adds additional 30 pixels to the bottom of the HStack, total 60
                .padding(.bottom, 30)
            }
            // This spacer pushes the header to the top
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false))
    }
}

// This creates the sectionView that repeats in our scroll view
struct SectionView: View {
    var body: some View {
        VStack {
            // Creates the top element with title and image
            HStack(alignment: .top) {
                Text("Prototype designs in SwiftUI")
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(.white)
                // spaces them out to each side
                Spacer()
                Image("Logo1")
            }
            // Adds the title text below the header
            Text("18 Sections".uppercased())
                .frame(maxWidth: .infinity, alignment: .leading)
            // Adds the background image below the above text
            Image("Card1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
        }
            // Adds padding from parent Vstack, applies to the children views
        .padding(.top, 20)
        .padding(.horizontal, 20)
            // Sets a hard-coded frame
        .frame(width: 275, height: 275)
        .background(Color("card1"))
            // round corners
        .cornerRadius(30)
            // This shadow uses the same color as the image, and creates a shadow that blends with the white background (contextual shadow)
        .shadow(color: Color("card1").opacity(0.3), radius: 20, x: 0, y: 20)
    }
}
