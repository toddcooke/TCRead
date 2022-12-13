//
// Created by Todd Cooke on 12/13/22.
//

import Foundation

import SwiftUI

struct BookDetailView: View {
    var book: Book
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://www.gutenberg.org/cache/epub/\(book.textNum)/pg\(book.textNum).cover.medium.jpg"))
            Text(book.title).fontWeight(.heavy)
            Divider()

            Text("Send to kindle")//todo: add button to send to kindle
        }
    }
}