//
//  CourseList.swift
//  CodeDesignApp
//
//  Created by Yashas Rao on 4/28/20.
//  Copyright © 2020 CodeDesign. All rights reserved.
//

import SwiftUI

struct CourseList: View {
    // This currently uses 2 states, which will be changed in the next section
    @State var show = false
    @State var show2 = false
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                CourseView(show: $show)
                // This geometry reader allows us to take the second CourseView object and use it to animate this view to the top when pressed. We use the show2 state, so when pressed and it gets toggled. That's why it is a binding (show) in the courseView component. that's how it toggles the variable in the CourseList parent view.
                GeometryReader { geometry in
                    CourseView(show: self.$show2)
                        // Animates the cell to the top, when pressed, or keeps it where iti s
                        .offset(y: self.show2 ? -geometry.frame(in: .global).minY : 0)
                }
                .frame(height: show2 ? screen.height : 280)
                    // When using geometry reader, the padding gets ignored. So we have to manually set it to screen.width - 60 so it looks identical to the first CourseList when not animated out.
                .frame(maxWidth: show2 ? .infinity : screen.width - 60)
            }
            .frame(width: screen.width)
        }
    }
}

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList()
    }
}

struct CourseView: View {
    @Binding var show: Bool
    var body: some View {
        // This Z-stack allows us to have content underneath the existing card view. This aligns whichever component in the Z-stack to the top, and to the biggest component
        ZStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 30) {
                Text("Take your SwiftUI app to the App Store with advanced techniques like API data, packages and CMS.")
                Text("About this course").font(.title).bold()
                Text("This course is unlike any other. We care about design and want to make sure that you get better at it in the process. It was written for designers and developers who are passionate about collaborating and building real apps for iOS and macOS. While it's not one codebase for all apps, you learn once and can apply the techniques and controls to all platforms with incredible quality, consistency and performance. It's beginner-friendly, but it's also packed with design tricks and efficient workflows for building great user interfaces and interactions.")
                Text("Minimal coding experience required, such as in HTML and CSS. Please note that Xcode 11 and Catalina are essential. Once you get everything installed, it'll get a lot friendlier! I added a bunch of troubleshoots at the end of this page to help you navigate the issues you might encounter.")
            }
            .padding(30)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? .infinity : 280)
                // This offset pushes the text below the card to ensure that it is visible
            .offset(y: show ? 460 : 0)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
                // changes the opacity to show
            .opacity(show ? 1 : 0)

            VStack {
                // This creates the horizantal view of the title at the top of the CourseView and aligns this to the top
                HStack(alignment: .top) {
                    // 8 pixels stacked on top of each other, aligned to leading
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Swift UI Advanced")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color.white)
                        Text("20 sections")
                            .foregroundColor(Color.white.opacity(0.7))
                    }
                    // spacer forces the image and the HStack takes the max width between the frame width
                    Spacer()
                    // This Z-stack puts two buttons on top of each other. Based on the state, will change the button
                    ZStack {
                        Image(uiImage: #imageLiteral(resourceName: "Logo1"))
                            .opacity(show ? 0 : 1)
                        VStack {
                            Image(systemName: "xmark")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color.white)
                        }
                        .frame(width: 36, height: 36)
                        .background(Color.black)
                        .clipShape(Circle())
                        .opacity(show ? 1 : 0)
                    }
                }
                // This pushes the HStack to the top, and the other image down to the bottom
                Spacer()
                Image(uiImage: #imageLiteral(resourceName: "Card6"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: 140, alignment: .top)
            }
                // Adds more padding when showState is true
            .padding(show ? 30 : 20)
            .padding(.top, show ? 30 : 0)
                // This forces the view, when show, to take the maximum height and width (while respecting the safearealayout)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? 460 : 280)
            .background(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
                // Creates the smooth rounded corners
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)).opacity(0.3), radius: 20, x: 0, y: 20)
            .onTapGesture {
                // toggles the state when tapped
                self.show.toggle()
            }
        }
            // We set the frame based on the show state, and this animation kicks in
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        // This forces us to ignore safearealayout, stretches to max
        .edgesIgnoringSafeArea(.all)
    }
}
