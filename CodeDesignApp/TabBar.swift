//
//  TabBar.swift
//  CodeDesignApp
//
//  Created by Yashas Rao on 4/25/20.
//  Copyright © 2020 CodeDesign. All rights reserved.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        // Creates the tab bar controller basically by using the TabView
        TabView {
            // This instantiates the homeView, and sets the tabBar image and text
            Home().tabItem {
                Image(systemName: "play.circle.fill")
                Text("Home")
            }
            // This instantiates the ContentView, and sets the image and text
            ContentView().tabItem {
                Image(systemName: "rectangle.stack.fill")
                Text("Certificates")
            }
        }
            // Without this, the status bar at the top would make the view look strange, so this nudges our content to the top
        .edgesIgnoringSafeArea(.top)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
