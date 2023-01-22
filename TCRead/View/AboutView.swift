//
//  AboutView.swift
//  TCRead
//
//  Created by Todd Cooke on 1/17/23.
//

import Foundation
import SwiftUI

struct AboutView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("About TCRead").font(.title)
                Text("TCRead lets you search for free ebooks and email them to your kindle.").padding()
                Text("To use TCRead:")
                Text("1. When you first start the app, enter your kindle email. You can find this here: https://www.amazon.com/sendtokindle/email#s2k-email-step-by-step")
                Text("2. Search for a book")
                Text("3. Click send to kindle")
                Text("4. Click the top right button which sends the book from your email to your kindle.")
                Text("5. Go to your email and click 'Verify Request'")
                Text("6. Check your kindle for your book - make sure it has wifi enabled.")
            }

            Divider()
            Text("All book content presented by this app comes from https://www.gutenberg.org. Project Gutenberg makes copyright-free books freely available.")
        }.padding()
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
