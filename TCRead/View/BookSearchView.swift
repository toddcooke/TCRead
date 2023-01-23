import SwiftUI

struct BookSearchView: View {
    var bookRepo = BookRepository.shared!
    @EnvironmentObject var modelData: ModelData
    @State private var searchText = ""
    @State private var bookId: String?
    @State private var searchingByTitle = true
    @State private var showSettings = false
    
    var body: some View {
        NavigationSplitView {
            Toggle(isOn: $searchingByTitle) {
                Text(searchingByTitle ? "Searching by title" : "Searching by author")
            }
            .toggleStyle(.automatic)
            .tint(.gray)
            .padding([.leading, .trailing])

            List(searchResults, selection: $bookId) { book in
                NavigationLink(value: book.textNum) {
                    VStack(alignment: .leading) {
                        Text(book.title).bold()
                        Text(book.authors.formatAuthor()).font(.caption)
                    }
                }
            }
            .navigationSplitViewStyle(.balanced)
            .navigationTitle("Book Search")
            .toolbar {
                ToolbarItem {
                    NavigationLink {
                        AboutView()
                    } label: {
                        Label("About", systemImage: "questionmark.circle.fill")
                    }
                }
                ToolbarItem {
                    Menu {
                        Button("Change kindle email"){
                            showSettings.toggle()
                        }
                    } label: {
                        Label("Settings", systemImage: "gearshape.fill")
                    }
                }
            }
        } detail: {
            if let bookId {
                if let book = bookRepo.getBookById(bookId) {
                    BookDetailView(book: book)
                }
            }
        }
        .sheet(isPresented: $showSettings){
            EmailPromptView().environmentObject(modelData)
        }
        .searchable(text: $searchText)
    }

    var searchResults: [Book] {
        if searchText.isEmpty {
            return []
        } else if searchingByTitle {
            return bookRepo.getBooksByTitle(searchText)
        } else {
            return bookRepo.getBooksByAuthor(searchText)
        }
    }
}

struct BookSearchView_Previews: PreviewProvider {
    static var previews: some View {
        BookSearchView()
    }
}
