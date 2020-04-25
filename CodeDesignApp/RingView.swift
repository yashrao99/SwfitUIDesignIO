//
//  RingView.swift
//  CodeDesignApp
//
//  Created by Yashas Rao on 4/25/20.
//  Copyright © 2020 CodeDesign. All rights reserved.
//

import SwiftUI

struct RingView: View {
    // When building these components, you can set class/struct variables at the top. These variables can be sued throughout your code for scalability purposes.
    var color1 = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    var color2 = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
    var height: CGFloat = 88
    var width: CGFloat = 88
    var percent: CGFloat = 88
    @Binding var show: Bool

    var body: some View {
        // These values depend on the values defined in the struct level. Now we can access those values, and then use them in our calculations when building the UI component. Go through each component and ensure that the multiplier is set on the values which need it. Then you can change the frame and width and the UI component will scale properly.
        let multiplier = width / 44
        let progress = 1 - (percent / 100)
        // Embedding in ZStack so we can put the outer circle behind the progress circle
        return ZStack {
            // This creates teh outermost circle, which is our background progress bar out of 100%
            Circle()
                .stroke(Color.black.opacity(0.1), style: StrokeStyle(lineWidth: 5 * multiplier))
                .frame(width: width, height: height)
            // this creates the actual circle used to track progress
            Circle()
                // The trim trims the circle. The values work differently. From 0.1 to 1 means that it will trim 0-10% while keeping 10-100%.
                .trim(from: show ? progress : 1, to: 1)
                // LinearGradient - can use an array of color literals and then it will auto-apply the gradient for you
                // LineWidth = width of line
                // line cap & linejoin - when the line is dashed, this affects how each dash looks
                // dash - this creates the dash looked. The two values in teh array feel like x,y length of the dashes. [0, 0] is nothing where as [0, 1] or [1,0] is the full line.
                .stroke(LinearGradient(gradient: Gradient(colors: [Color(color1), Color(color2)]), startPoint: .topTrailing, endPoint: .bottomLeading),
                        style: StrokeStyle(lineWidth: 5 * multiplier, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [1, 0], dashPhase: 0)
            )
                // this rotates the starting point by 90 deg. ie if startPoint is trailing (far right), it will now be bottom
                .rotationEffect(Angle(degrees: 90))
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                .frame(width: width, height: height)
                .shadow(color: Color(color2).opacity(0.1), radius: 3 * multiplier, x: 0, y: 3 * multiplier)

            // This creates the text within the innermost circle, that will display a text value of our progress
        Text("\(Int(percent))%")
            .font(.system(size: 14 * multiplier))
            .fontWeight(.bold)
            .onTapGesture {
                self.show.toggle()
            }
        }
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView(show: .constant(true))
    }
}
