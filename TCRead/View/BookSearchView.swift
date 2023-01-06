import SwiftUI

struct BookSearchView: View {
    var bookRepo = BookRepository.shared
    @State private var searchText = ""
    @State private var bookId: String?

    var body: some View {
        NavigationSplitView {
            List(searchResults, selection: $bookId) { book in
                NavigationLink(book.title, value: book.textNum)
            }
            .navigationSplitViewStyle(.balanced)
            .navigationTitle("Book Search")
        } detail: {
            if let bookId {
                BookDetailView(book: bookRepo.getBooksById([bookId]).last!)
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
