//
//  CourseList.swift
//  CodeDesignApp
//
//  Created by Yashas Rao on 4/28/20.
//  Copyright © 2020 CodeDesign. All rights reserved.
//

import SwiftUI

struct CourseList: View {
    var body: some View {
        VStack {
            CourseView()
        }
    }
}

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList()
    }
}

struct CourseView: View {
    @State var show = false
    var body: some View {
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
                Image(uiImage: #imageLiteral(resourceName: "Logo1"))
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
        .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? .infinity : 280)
        .background(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))
            // Creates the smooth rounded corners
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)).opacity(0.3), radius: 20, x: 0, y: 20)
            // We set the frame based on the show state, and this animation kicks in
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .onTapGesture {
            // toggles the state when tapped
            self.show.toggle()
        }
            // This forces us to ignore safearealayout, stretches to max
        .edgesIgnoringSafeArea(.all)
    }
}
