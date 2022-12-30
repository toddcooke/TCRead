//
//  TCReadApp.swift
//  TCRead
//
//  Created by Todd Cooke on 12/9/22.
//

import SwiftUI

@main
struct TCReadApp: App {
    static var bookDateFormatter = DateFormatter()
    @StateObject private var modelData = ModelData()
    
    init() {
        TCReadApp.bookDateFormatter.dateFormat = "YYYY/MM/dd"
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                    .environmentObject(modelData)

        }
    }
}
