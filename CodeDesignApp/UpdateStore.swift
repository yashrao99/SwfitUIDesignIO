//
//  UpdateStore.swift
//  CodeDesignApp
//
//  Created by Yashas Rao on 4/25/20.
//  Copyright © 2020 CodeDesign. All rights reserved.
//

import SwiftUI
import Combine

// This Published class will act as our datastore for the various updates that will occur during a session. (Updates from backend/API, modifications from the user side, etc.)
class UpdateStore: ObservableObject {
    @Published var updates: [Update] = updateData
}
