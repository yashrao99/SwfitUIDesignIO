//
//  UpdateList.swift
//  CodeDesignApp
//
//  Created by Yashas Rao on 4/21/20.
//  Copyright © 2020 CodeDesign. All rights reserved.
//

import SwiftUI

struct UpdateList: View {
    var body: some View {
        // This creates a navigation controller
        NavigationView {
            // This List, creates a tableView. You can pass in your viewModel struct directly into this List
            List(updateData) { update in
                // This link is the desination. If this cell is selected, then push to a new view with the struct field of text
                NavigationLink(destination: Text(update.text)) {
                    // This is the UITableViewCell customization
                    HStack {
                        // Add the image on the left side of the Hstack (goes first)
                        Image(update.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .background(Color.black)
                            .cornerRadius(20)
                            // adds padding of 4 on the trailing to give some space
                            .padding(.trailing, 4)
                        // Leading alignment plus 8 pixels of space between each element
                        VStack(alignment: .leading, spacing: 8.0) {
                            Text(update.title)
                                .font(.system(size: 20, weight: .bold))
                            Text(update.text)
                                .lineLimit(2)
                                .font(.subheadline)
                                .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                            Text(update.date)
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.secondary)
                        }
                    }
                        // 8 pixels top and bottom of each cell
                    .padding(.vertical, 8)
                }
            }
        .navigationBarTitle(Text("Updates"))
        }
    }
}

struct UpdateList_Previews: PreviewProvider {
    static var previews: some View {
        UpdateList()
    }
}

struct Update: Identifiable {
    var id = UUID()
    var image: String
    var title: String
    var text: String
    var date: String
}

let updateData = [
    Update(image: "Card1", title: "SwiftUI Advanced", text: "Take your SwiftUI app to the App Store with advanced techniques like API data, packages and CMS.", date: "JAN 1"),
    Update(image: "Card2", title: "Webflow", text: "Design and animate a high converting landing page with advanced interactions, payments and CMS", date: "OCT 17"),
    Update(image: "Card3", title: "ProtoPie", text: "Quickly prototype advanced animations and interactions for mobile and Web.", date: "AUG 27"),
    Update(image: "Card4", title: "SwiftUI", text: "Learn how to code custom UIs, animations, gestures and components in Xcode 11", date: "JUNE 26"),
    Update(image: "Card5", title: "Framer Playground", text: "Create powerful animations and interactions with the Framer X code editor", date: "JUN 11")
]
