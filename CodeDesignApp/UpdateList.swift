//
//  UpdateList.swift
//  CodeDesignApp
//
//  Created by Yashas Rao on 4/21/20.
//  Copyright © 2020 CodeDesign. All rights reserved.
//

import SwiftUI

struct UpdateList: View {
    @ObservedObject var store = UpdateStore()
    
    func addUpdate() {
        store.updates.append(Update(image: "Card1", title: "New Item", text: "Text", date: "Jan1"))
    }

    var body: some View {
        // This creates a navigation controller
        NavigationView {
            // This List, creates a tableView. You can pass in your viewModel struct directly into this List. Here we are using our custom dataStore (look above) rather than the hard-coded data
            List {
                // This link is the desination. If this cell is selected, then push to a new view with the data model. Must be defined as a var in the view we are pushing to
                // The ForEach loop allows us to add the onMove and onDelete modifier since the forEach allows us to access each cell in the store.updates datamodel since each cell has a different indexPath, etc.
                ForEach(store.updates) { update in
                    NavigationLink(destination: UpdateDetail(update: update)) {
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
                    // In order to get this functionality, each cell needed to be separated into it's own forEach loop. This allows us to place the onDelete and the onMove modifiers.
                .onDelete { index in
                    self.store.updates.remove(at: index.first!)
                }
                .onMove { (source: IndexSet, destination: Int) in
                    self.store.updates.move(fromOffsets: source, toOffset: destination)
                }
            }
                // Navigation Bar customization made super simple. Can set the title, trailing, leading buttons, and their respective attributes with just a few lines
            .navigationBarTitle(Text("Updates"))
            .navigationBarItems(leading: Button(action: addUpdate) {
                    Text("Add Update")
            }, trailing: EditButton())
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
