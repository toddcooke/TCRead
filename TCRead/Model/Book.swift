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

//    func bookItems() -> Array<some Identifiable> {
//        [String(textNum), type, ContentView.bookDateFormatter.string(from: issued), title, language, authors, subjects, locc, bookshelves].id
//    }

}
