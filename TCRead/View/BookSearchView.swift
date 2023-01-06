import SwiftUI

struct BookSearchView: View {
    var bookRepo = BookRepository.shared
    let title = "Book Search"
    @State private var searchText = ""
    @State private var selection: Book? = nil
    @State private var bookIds: String?

    var body: some View {
        NavigationSplitView {
            List(searchResults, selection: $bookIds) { book in
                NavigationLink(book.title, value: book.textNum)
            }
            .navigationSplitViewStyle(.balanced)
            .navigationTitle(title)
        } detail: {
            if let bookIds {
                BookDetailView(book: bookRepo.getBooksById([bookIds]).last!)
            }
        }
        .searchable(text: $searchText)
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
        BookSearchView()
    }
}
