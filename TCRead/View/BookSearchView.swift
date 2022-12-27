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
        NavigationStack {
            List {
                ForEach(searchResults, id: \.self) { book in
                    NavigationLink {
                        BookDetailView(book: book)
                    } label: {
                        VStack{
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
