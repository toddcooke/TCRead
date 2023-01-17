//
//  AboutView.swift
//  TCRead
//
//  Created by Todd Cooke on 1/17/23.
//

import Foundation
import SwiftUI

struct AboutView: View {
    @Binding var isPresented: Bool

    var body: some View {
        VStack {
            Text("TCRead").font(.title).padding()
            Text("TCRead lets you search for free ebooks and email them to your kindle. All book content presented by this app comes from gutenberg.org. Gutenberg has the cool mission of making copyright-free books easily and freely available. If you can, consider supporting them: https://www.gutenberg.org/donate")

            Button("Done") {
                isPresented.toggle()
            }.buttonStyle(.borderedProminent)
        }.padding()
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView(isPresented: .constant(false))
    }
}
