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

struct CatalogEntry {
    var textNum: String
    var type: String
    var issued: String
    var title: String
    var language: String
    var authors: String
    var subjects: String
    var locc: String
    var bookshelves: String
}


struct Catalog {
    var gutenbergCatalogUrl = "https://www.gutenberg.org/cache/epub/feeds/pg_catalog.csv"
    var fm = FileManager()

    func getCatalogStrings() -> ArraySlice<String> {
        if let filepath = Bundle.main.path(forResource: "pg_catalog", ofType: "csv") {
            do {
                let lines = try String(contentsOfFile: filepath).components(separatedBy: "\n").dropFirst()
                return lines
            } catch {
                // contents could not be loaded
                print("error reading file")
                return []
            }
        } else {
            // example.txt not found!
            print("pg_catalog.csv file not found")
            return []
        }
    }
}


struct ContentView: SwiftUI.View {
    @State private var searchText = ""
    let names = ["Holly", "Josh", "Rhonda", "Ted"]

    init() {
        var cat = Catalog()
        cat.getCatalogStrings()
//        var csv = cat.loadCsv()
//        cat.insertCatalogToDb()
//        var db = Repository.shared
//        var res = db.insert(name: "hello", date: Date.now)
//        print(res)


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
