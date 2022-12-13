//
//  ContentView.swift
//  TCRead
//
//  Created by Todd Cooke on 12/9/22.
//

import SwiftUI

struct ContentView: SwiftUI.View {
    @State private var searchText = ""
    var bookRepo = BookRepository.shared
    static let bookDateFormatter = DateFormatter()

    init() {
        ContentView.bookDateFormatter.dateFormat = "YYYY/MM/dd"
        if bookRepo.getBooksById([1]).isEmpty {
            let books = bookRepo.catalogStringsToBooks(strings: bookRepo.getCatalogCsv())
            _ = bookRepo.insert(books: books)
        } else {
            print("book table already created")
        }
    }

    var body: some SwiftUI.View {
        NavigationStack {
            List {
                ForEach(searchResults, id: \.self) { book in
                    NavigationLink {
                        BookDetailView(book: book)
                    } label: {
                        Text(book.title)
                    }
                }
            }
                    .navigationTitle("Gutenberg search")
        }
                .searchable(text: $searchText)
    }

    var searchResults: [Book] {
        if searchText.isEmpty {
            return []
//        return bookRepo.getBooksById([1])
        } else {
            return bookRepo.getBooksByTitle(searchText)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        ContentView()
    }
}
