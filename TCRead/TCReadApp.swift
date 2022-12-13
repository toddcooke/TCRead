//
//  TCReadApp.swift
//  TCRead
//
//  Created by Todd Cooke on 12/9/22.
//

import SwiftUI

@main
struct TCReadApp: App {
    @State private var searchText = ""
    static let bookDateFormatter = DateFormatter()

    init(){
        TCReadApp.bookDateFormatter.dateFormat = "YYYY/MM/dd"
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
