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
    @State var showUpdate = false
    @Binding var showContent: Bool

    var body: some View {
        ScrollView {
            VStack {
                // This HStack is the header at the top
                HStack {
                    Text("Watching")
                        .font(.system(size: 28, weight: .bold))
                        .modifier(CustomFontModifier())
                    // spacer pushes the title and the avatar image to opposite sides
                    Spacer()
                    AvatarView(showProfile: $showProfile)

                    Button(action: { self.showUpdate.toggle() }) {
                        Image(systemName: "bell")
                            .renderingMode(.original)
                            .font(.system(size: 16, weight: .medium))
                            .frame(width: 36, height: 36)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                    }
                        // MODAL PRESENTATION IN SWIFT UI
                        // This .sheet creates a view, defined within the closure and is bound to the local state of `showUpdate`. That means if showPresented is true, then isPresented is true and our ContentView object is displayed modally.
                    .sheet(isPresented: $showUpdate) {
                        UpdateList()
                    }
                }
                // Adds teh 16 pixels on all 4 sides
                .padding(.horizontal)
                // Adds additional 14 to the leading anchor (30 total)
                .padding(.leading, 14)
                // Adds additional 30 to the top anchor (46 total)
                .padding(.top, 30)
                
                // This creates the ringView right below our top menu view. We also add some text to the right of the RingView.
                ScrollView(.horizontal, showsIndicators: false) {
                    WatchRingsView()
                        .padding(.horizontal, 30)
                        .padding(.bottom, 30)
                        .onTapGesture {
                            self.showContent = true
                    }
                }
                
                // SCROLL VIEW, setting the direction on the init is NOT the scrolling direction
                ScrollView(.horizontal, showsIndicators: false) {
                    // Embedding the items in either or HStack or VStack will determine the scroll direction
                    HStack(spacing: 20) {
                        // cmd + click -> repeat creates simple, editable for loop to repeat UI elements
                        // As we create the Hstack, we can use the ForEach to intialize each sectionView with a sectionData datasource to populate the Hstack
                        ForEach(sectionData) { item in
                            // Geometry reader allows us to apply cool animations, same concept as HStack and Vstack in terms of container
                            GeometryReader { geometry in
                                SectionView(section: item)
                                    // We are adding a 3D effect to the top right corner (minX). The rotation subtracts 30 from the minX, which flattens it for our view. The division by 20 slows the animation down. The +/- determines the direction. We use the Y-axis on the rotation to give it depth about the y-axis
                                    .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX - 30) / -20), axis: (x: 0, y: 10, z: 0))
                            }
                            .frame(width: 275, height: 275)
                        }
                    }
                    // Adds 30 pixels from all sides of the HStack
                    .padding(30)
                    // Adds additional 30 pixels to the bottom of the HStack, total 60
                    .padding(.bottom, 30)
                }
                .offset(y: -30)
                HStack {
                    Text("Courses")
                        .font(.title).bold()
                    
                    Spacer()
                }
                .padding(.leading, 30)
                .offset(y: -60)
                SectionView(section: sectionData[2], width: screen.width - 60, height: 275)
                    .offset(y: -60)
                // This spacer pushes the header to the top
                Spacer()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false), showContent: .constant(false))
    }
}

// This creates the sectionView that repeats in our scroll view
struct SectionView: View {
    var section: Section
    var width: CGFloat = 275
    var height: CGFloat = 275
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
        .frame(width: width, height: height)
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

struct WatchRingsView: View {
    var body: some View {
        // Creates the content H-stack for the scrollView
        HStack(spacing: 30) {
            HStack(spacing: 12.0) {
                RingView(color1: #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1), color2: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), height: 44, width: 44, percent: 68, show: .constant(true))
                VStack(alignment: .leading, spacing: 4.0) {
                    Text("6 minutes left").bold().modifier(FontModifier(style: .subheadline))
                    Text("Watched 10 mins today").modifier(FontModifier(style: .caption))
                }
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            HStack(spacing: 12.0) {
                RingView(color1: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), color2: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), height: 32, width: 32, percent: 68, show: .constant(true))
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            HStack(spacing: 12.0) {
                RingView(color1: #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), color2: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), height: 32, width: 32, percent: 68, show: .constant(true))
            }
            .padding(8)
            .background(Color.white)
            .cornerRadius(20)
            .modifier(ShadowModifier())
        }
    }
}
