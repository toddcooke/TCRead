//
//  TCReadApp.swift
//  TCRead
//
//  Created by Todd Cooke on 12/9/22.
//

import SwiftUI

@main
struct TCReadApp: App {
    @StateObject private var modelData = ModelData()

    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(modelData)
        }
    }
}
