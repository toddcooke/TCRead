//
//  ContentView.swift
//  TCRead
//
//  Created by Todd Cooke on 12/9/22.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .bookSearch

    enum Tab {
        case bookSearch
        case ereaderConfig
    }

//    var body: some View {

//        BookSearchView()
//    }
    var body: some View {
        TabView(selection: $selection) {
            BookSearchView()
                    .tabItem {
                        Label("Book Search", systemImage: "book")
                    }
                    .tag(Tab.bookSearch)
            EreaderConfigView()
                    .tabItem {
                        Label("E-reader Config", systemImage: "gear")
                    }
                    .tag(Tab.ereaderConfig)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
