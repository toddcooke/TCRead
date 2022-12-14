//
//  Book.swift
//  TCRead
//
//  Created by Todd Cooke on 12/13/22.
//

import Foundation

struct Book: Encodable, Hashable {
    var textNum: Int
    var type: String
    var issued: Date
    var title: String
    var language: String
    var authors: String
    var subjects: String
    var locc: String
    var bookshelves: String


   static func exampleBook() ->Book {
        Book(textNum: 0, type: "book", issued: Date.now, title: "Alice in wonderland", language: "en", authors: "Lewis Carrol", subjects: "Fiction", locc: "PR", bookshelves: "Childrens Literature")
    }
}
