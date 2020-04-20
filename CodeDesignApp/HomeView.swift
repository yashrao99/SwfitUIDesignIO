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
            .padding(.horizontal)
            .padding(.top, 30)
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
