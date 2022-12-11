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


struct Catalog {
    var gutenbergCatalogUrl = "https://www.gutenberg.org/cache/epub/feeds/pg_catalog.csv"
    var fm = FileManager()
    var db = Repository.shared

    func insertCatalog() {
        var books = catalogStringsToBooks(strings: getCatalogCsv())
        var res = db.insert(books: books)
        print(res)
    }

    func catalogStringsToBooks(strings: EnumeratedCSV?) -> [Book] {
        var books: [Book] = []
        if strings == nil {
            return []
        }
        for row in strings!.rows {
            books.append(Book(
                    textNum: row[0],
                    type: row[1],
                    issued: row[2],
                    title: row[3],
                    language: row[4],
                    authors: row[5],
                    subjects: row[6],
                    locc: row[7],
                    bookshelves: row[8])
            )
        }
        return books
    }

    func getCatalogCsv() -> EnumeratedCSV? {
        if let filepath = Bundle.main.path(forResource: "pg_catalog", ofType: "csv") {
            do {
                let lines = try String(contentsOfFile: filepath)
                let csv = try EnumeratedCSV(string: lines)
                return csv
            } catch {
                print("error reading csv")
                return nil
            }
        } else {
            print("pg_catalog.csv file not found")
            return nil
        }
    }
}


struct ContentView: SwiftUI.View {
    @State private var searchText = ""
    let names = ["Holly", "Josh", "Rhonda", "Ted"]

    init() {
        var cat = Catalog()
        cat.insertCatalog()


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
            return names
        } else {
            return names.filter {
                $0.contains(searchText)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        ContentView()
    }
}
