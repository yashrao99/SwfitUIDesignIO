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
                    // As we create the Hstack, we can use the ForEach to intialize each sectionView with a sectionData datasource to populate the Hstack
                    ForEach(sectionData) { item in
                        SectionView(section: item)
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
    var section: Section
    var body: some View {
        VStack {
            // Creates the top element with title and image
            HStack(alignment: .top) {
                Text(section.title)
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 160, alignment: .leading)
                    .foregroundColor(.white)
                // spaces them out to each side
                Spacer()
                Image(section.logo)
            }
            // Adds the title text below the header
            Text(section.text.uppercased())
                .frame(maxWidth: .infinity, alignment: .leading)
            // Adds the background image below the above text
            section.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 210)
        }
            // Adds padding from parent Vstack, applies to the children views
        .padding(.top, 20)
        .padding(.horizontal, 20)
            // Sets a hard-coded frame
        .frame(width: 275, height: 275)
            .background(section.color)
            // round corners
        .cornerRadius(30)
            // This shadow uses the same color as the image, and creates a shadow that blends with the white background (contextual shadow)
            .shadow(color: section.color.opacity(0.3), radius: 20, x: 0, y: 20)
    }
}

// This is the viewModel. We create this struct, and pass it into the where we create the view. This struct contains all the data, like your datasource for tableViews/ColelctionViews)

struct Section: Identifiable {
    var id = UUID()
    var title: String
    var text: String
    var logo: String
    var image: Image
    var color: Color
}
let sectionData = [Section(title: "Prototype designs in Swift UI", text: "18 Sections", logo: "Logo1", image: Image(uiImage: #imageLiteral(resourceName: "Card4")), color: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))),
                   Section(title: "Build a SwiftUI app", text: "20 Sections", logo: "Logo1", image: Image(uiImage: #imageLiteral(resourceName: "Card2")), color: Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))),
                   Section(title: "SwiftUI Advanced", text: "20 Sections", logo: "Logo1", image: Image(uiImage: #imageLiteral(resourceName: "Card4")), color: Color(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)))
]
