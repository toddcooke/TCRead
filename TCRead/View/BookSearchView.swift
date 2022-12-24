import SwiftUI

struct BookSearchView: View {
    var bookRepo = BookRepository.shared
    @State private var searchText = ""

    init() {
        if bookRepo.getBooksById([1]).isEmpty {
            let books = bookRepo.catalogStringsToBooks(strings: bookRepo.getCatalogCsv())
            _ = bookRepo.insert(books: books)
        } else {
            print("book table already created")
        }
    }

    let colors: [Color] = [.purple, .pink, .orange]
    @State private var selection: Color? = nil // Nothing selected by default.
    var body: some View {
        #if os(macOS)
        NavigationSplitView {
            List(colors, id: \.self, selection: $selection) { color in
                NavigationLink(color.description, value: color)
            }
        } detail: {
            if let color = selection {
                Text("nice: " + color.description)
            } else {
                Text("Pick a color")
            }
        }
        #else
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
                    .navigationTitle("Book search")
        }
                .searchable(text: $searchText)
        #endif
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

struct BookSearchView_Previews: PreviewProvider {
    static var previews: some View {
        BookSearchView()
    }
}
