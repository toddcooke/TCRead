//
//  ContentView.swift
//  TCRead
//
//  Created by Todd Cooke on 12/9/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData

    var body: some View {
        let takingScreenshots = getEnvVar("SKIP_EMAIL")

        if takingScreenshots != nil || modelData.kindleEmail != nil {
            BookSearchView()
        } else {
            EmailPromptView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
