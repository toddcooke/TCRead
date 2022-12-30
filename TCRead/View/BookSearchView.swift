import SwiftUI

struct BookSearchView: View {
    var bookRepo = BookRepository.shared
    @State private var searchText = ""

    init(preview: Bool) {
        searchText = "alice"
    }

    init() {
    }

    var body: some View {
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
