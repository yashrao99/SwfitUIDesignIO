//
//  RingView.swift
//  CodeDesignApp
//
//  Created by Yashas Rao on 4/25/20.
//  Copyright © 2020 CodeDesign. All rights reserved.
//

import SwiftUI

struct RingView: View {
    var body: some View {
        // Embedding in ZStack so we can put the outer circle behind the progress circle
        ZStack {
            // This creates teh outermost circle, which is our background progress bar out of 100%
            Circle()
                .stroke(Color.black.opacity(0.1), style: StrokeStyle(lineWidth: 5))
                .frame(width: 44, height: 44)
            // this creates the actual circle used to track progress
            Circle()
                // The trim trims the circle. The values work differently. From 0.1 to 1 means that it will trim 0-10% while keeping 10-100%.
                .trim(from: 0.2, to: 1)
                // LinearGradient - can use an array of color literals and then it will auto-apply the gradient for you
                // LineWidth = width of line
                // line cap & linejoin - when the line is dashed, this affects how each dash looks
                // dash - this creates the dash looked. The two values in teh array feel like x,y length of the dashes. [0, 0] is nothing where as [0, 1] or [1,0] is the full line.
                .stroke(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))]), startPoint: .topTrailing, endPoint: .bottomLeading),
                        style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [1, 0], dashPhase: 0)
            )
                // this rotates the starting point by 90 deg. ie if startPoint is trailing (far right), it will now be bottom
                .rotationEffect(Angle(degrees: 90))
                .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                .frame(width: 44, height: 44)
                .shadow(color: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)).opacity(0.1), radius: 3, x: 0, y: 3 )

            // This creates the text within the innermost circle, that will display a text value of our progress
        Text("82%")
            .font(.subheadline)
            .fontWeight(.bold)
        }
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView()
    }
}
