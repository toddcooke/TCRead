import SwiftUI

struct BookSearchView: View {
    var bookRepo = BookRepository.shared
    @State private var searchText = ""
    @State private var selection: Book? = nil
    @State private var bookIds: Set<String> = []
    let title = "Book Search"

    init(preview: Bool) {
        searchText = "alice"
        selection = Book.exampleBook()
    }

    init() {
    }

    var body: some View {
        #if targetEnvironment(macCatalyst)
        NavigationSplitView {
            List(searchResults, selection: $bookIds) { book in
                NavigationLink(book.title, value: book.textNum)
            }
            .navigationSplitViewStyle(.balanced)
            .navigationTitle(title)
        } detail: {
            if !bookIds.isEmpty {
                BookDetailView(book: bookRepo.getBooksById(Array(bookIds)).last!)
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
            .navigationTitle(title)
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
