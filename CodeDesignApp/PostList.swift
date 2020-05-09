//
//  PostList.swift
//  CodeDesignApp
//
//  Created by Yashas Rao on 5/9/20.
//  Copyright © 2020 CodeDesign. All rights reserved.
//

import SwiftUI

struct PostList: View {
    // This Observed object is hwo you can pass the data from the API
    @ObservedObject var store = Datastore()
    
    var body: some View {
        // This creates the post list,
        List(store.posts) { post in
            VStack(alignment: .leading, spacing: 8) {
                Text(post.title).font(.system(.title, design: .serif)).bold()
                Text(post.body).font(.subheadline).foregroundColor(.secondary)
            }
        }
    }
}

struct PostList_Previews: PreviewProvider {
    static var previews: some View {
        PostList()
    }
}
