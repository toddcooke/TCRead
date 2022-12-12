//
//  ContentView.swift
//  TCRead
//
//  Created by Todd Cooke on 12/9/22.
//

import SwiftUI
import Alamofire

import SwiftCSV

import SQLite


struct ContentView: SwiftUI.View {
    @State private var searchText = ""
    let names = ["Holly", "Josh", "Rhonda", "Ted"]
    var repo = Repository.shared

    init() {
        if repo.getBooksById([1]).isEmpty {
            let books = repo.catalogStringsToBooks(strings: repo.getCatalogCsv())
            let res = repo.insert(books: books)
            print(res)
        } else {
            print("book table already created")
        }
    }


    var body: some SwiftUI.View {
        NavigationStack {
            List {
                ForEach(searchResults, id: \.self) { name in
                    NavigationLink {
                        Text(name)
                    } label: {
                        Text(name)
                    }
                }
            }
                    .navigationTitle("Contacts")
        }
                .searchable(text: $searchText)
    }

    var searchResults: [String] {
        if searchText.isEmpty {
            return []
        } else {
            return repo.getBooksByTitle(titles: searchText.components(separatedBy: " ")).map { element in
                element.title
            }
//            return names.filter {
//                $0.contains(searchText)
//            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        ContentView()
    }
}
