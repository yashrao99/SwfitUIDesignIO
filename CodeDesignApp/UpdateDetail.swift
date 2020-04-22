//
//  UpdateDetail.swift
//  CodeDesignApp
//
//  Created by Yashas Rao on 4/21/20.
//  Copyright © 2020 CodeDesign. All rights reserved.
//

import SwiftUI

struct UpdateDetail: View {
    // Defines our datasource for this view, similar to datasource[indexPath.row]
    var update: Update = updateData[0]

    var body: some View {
        // Creates a quick tableView, no de-queueing cells etc
        List {
            // Creates simple Vstack with our datamodel information
            VStack(spacing: 20) {
                Image(update.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                Text(update.text)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
                // This creates the Big Title view. On a scrollview, it even automatically puts itself into the real navigation bar when contentOffset changes
            .navigationBarTitle(update.title)
        }
            // Can edit the styling of the tableView using these values
    .listStyle(PlainListStyle())
    }
}

struct UpdateDetail_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDetail()
    }
}
