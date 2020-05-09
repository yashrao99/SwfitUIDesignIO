//
//  DataStore.swift
//  CodeDesignApp
//
//  Created by Yashas Rao on 5/9/20.
//  Copyright © 2020 CodeDesign. All rights reserved.
//

import SwiftUI
import Combine

// The observableObject type is what should be used in the API. When we set the posts, it publishes the results to whoever is observing this. In this case, PostList view has the ObservedObject type that gets notified when this Posts call is finished.
class Datastore: ObservableObject {
    @Published var posts: [Post] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        API().getPosts() { posts in
            self.posts = posts
        }
    }
}
