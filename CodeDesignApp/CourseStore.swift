//
//  CourseStore.swift
//  CodeDesignApp
//
//  Created by Yashas Rao on 5/9/20.
//  Copyright © 2020 CodeDesign. All rights reserved.
//

import SwiftUI
import Contentful

let client = Client(spaceId: "ao12xwgeqntj", accessToken: "a4f9iij0lfnJPbCbe1zc9Ll3825nr6Z7IOFobXThI70")

func getArray() {
    let query = Query.where(contentTypeId: "course")
    
    client.fetchArray(of: Entry.self, matching: query) { result in
        print("Here is result \(result)")
    }
}
