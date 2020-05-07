//
//  CourseList.swift
//  CodeDesignApp
//
//  Created by Yashas Rao on 4/28/20.
//  Copyright © 2020 CodeDesign. All rights reserved.
//

import SwiftUI

struct CourseList: View {
    @State var courses = courseData
    @State var active = false
    @State var activeIndex = -1
    
    var body: some View {
        ZStack {
            Color.black.opacity(active ? 0.5 : 0)
                .animation(.linear)
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(spacing: 30) {
                    Text("Courses")
                        .font(.largeTitle).bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 30)
                        .padding(.top, 30)
                        .blur(radius: active ? 20 : 0)
                        
                    // This geometry reader allows us to take the second CourseView object and use it to animate this view to the top when pressed. We use the show2 state, so when pressed and it gets toggled. That's why it is a binding (show) in the courseView component. that's how it toggles the variable in the CourseList parent view.
                    ForEach(courses.indices, id: \.self) { index in
                        GeometryReader { geometry in
                            CourseView(
                                show: self.$courses[index].show,
                                course: self.courses[index],
                                active: self.$active,
                                index: index,
                                activeIndex: self.$activeIndex)
                                // Animates the cell to the top, when pressed, or keeps it where iti s
                                .offset(y: self.courses[index].show ? -geometry.frame(in: .global).minY : 0)
                                // This condition allows us to control the effects of the cards not being selected using activeIndex state. If no card is selected, it will default to the original state. However, since the binding is passed into each CourseView object, every time we toggle the card, the active index will be set. The other cards in the view will not be the active index, and will change opacity, scale, and animate out to the side
                                .opacity(self.activeIndex != index && self.active ? 0 : 1)
                                .scaleEffect(self.activeIndex != index && self.active ? 0.5 : 1)
                                .offset(x: self.activeIndex != index && self.active ? screen.width : 0)
                        }
                            // Geometry reader pushes the other objects in the scroll View. This is fine if you're okay with it. But if not, manually set the frame here. In the actual CourseView object, set the frame to trigger on the outer most containerView to adapt to the full screen based on the state of Show in the dataModel. However, the z-stack needs to be fixed so that the expanded courseView takes over the screen completely and you don't see the other components
                        .frame(height: 280)
                            // When using geometry reader, the padding gets ignored. So we have to manually set it to screen.width - 60 so it looks identical to the first CourseList when not animated out.
                            .frame(maxWidth: self.courses[index].show ? .infinity : screen.width - 60)
                            // DEFAULT - All objects default zIndex is 0, meaning that they are on the same plane. When one card is pressed, and show is toggled, it should take over the plane. Therefore, by setting the plane to 1 when card is shown, it takes over the screen without having to move the other objects
                            .zIndex(self.courses[index].show ? 1 : 0)
                    }
                }
                .frame(width: screen.width)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            }
                // This hides teh animation bar based on another state value in main container view
            .statusBar(hidden: active ? true : false)
            .animation(.linear)
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
    var course: Course
    @Binding var active: Bool
    var index: Int
    @Binding var activeIndex: Int
    
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
                        Text(course.title)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color.white)
                        Text(course.subtitle)
                            .foregroundColor(Color.white.opacity(0.7))
                    }
                    // spacer forces the image and the HStack takes the max width between the frame width
                    Spacer()
                    // This Z-stack puts two buttons on top of each other. Based on the state, will change the button
                    ZStack {
                        Image(uiImage: course.logo)
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
                Image(uiImage: course.image)
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
                .background(Color(course.color))
                // Creates the smooth rounded corners
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color(course.color).opacity(0.3), radius: 20, x: 0, y: 20)
            .onTapGesture {
                // toggles the state when tapped
                self.show.toggle()
                self.active.toggle()
                // If we're showing the card, set the active index so the other cards in the parent view know how to behave. Else, if nothing is showing, then set it to -1 (nothing active)
                if self.show {
                    self.activeIndex = self.index
                } else {
                    self.activeIndex = -1
                }
            }
        }
        .frame(height: course.show ? screen.height : 280)
            // We set the frame based on the show state, and this animation kicks in
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        // This forces us to ignore safearealayout, stretches to max
        .edgesIgnoringSafeArea(.all)
    }
}

// Creates the view data-model for the courseList so we can loop through rather than store a bunch of states for each data component
struct Course: Identifiable {
       var id = UUID()
       var title: String
       var subtitle: String
       var image: UIImage
       var logo: UIImage
       var color: UIColor
       var show: Bool
}

var courseData = [
   Course(title: "Prototype Designs in SwiftUI", subtitle: "18 Sections", image: #imageLiteral(resourceName: "Background1"), logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), show: false),
   Course(title: "SwiftUI Advanced", subtitle: "20 Sections", image: #imageLiteral(resourceName: "Card3"), logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), show: false),
   Course(title: "UI Design for Developers", subtitle: "20 Sections", image: #imageLiteral(resourceName: "Card4"), logo: #imageLiteral(resourceName: "Logo3"), color: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), show: false)
]
