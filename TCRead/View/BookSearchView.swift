import SwiftUI

struct BookSearchView: View {
    var bookRepo = BookRepository.shared
    @State private var searchText = ""
    @State private var selection: Book? = nil
    @State private var bookIds: Set<String> = []

    init(preview: Bool) {
        searchText = "alice"
    }

    init() {
    }

    var body: some View {
        #if targetEnvironment(macCatalyst)
        NavigationSplitView {
            List(searchResults, selection: $bookIds) { book in
                NavigationLink(book.title, value: book.title)
            }
        } detail: {
            // TODO: show book detail view
            if !bookIds.isEmpty{
                // TODO: selection seems buggy:
                // print selected book ids and books returned from db
                BookDetailView(book: bookRepo.getBooksById( Array(bookIds)).first!)
            }
        }
        .searchable(text: $searchText)
        #else
        NavigationStack {
            List {
                ForEach(searchResults, id: \.self) { book in
                    NavigationLink {
                        BookDetailView(book: book)
                    } label: {
                        VStack {
                            Text(book.title).bold()
                            Text(book.authors)
                        }
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
        } else {
            return bookRepo.getBooksByTitle(searchText)
        }
    }
}

struct BookSearchView_Previews: PreviewProvider {
    static var previews: some View {
        BookSearchView(preview: true)
    }
}
