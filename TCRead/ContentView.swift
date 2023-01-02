//
//  ContentView.swift
//  TCRead
//
//  Created by Todd Cooke on 12/9/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        BookSearchView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
