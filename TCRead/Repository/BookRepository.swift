//
// Created by Todd Cooke on 12/11/22.
//

import Foundation
import SQLite

class BookRepository {
    static let shared = BookRepository()

    private let booksTable = Table("books")
    private let textNum = Expression<String>("Text#")
    private let type = Expression<String>("Type")
    private let issued = Expression<String>("Issued")
    private let title = Expression<String>("Title")
    private let language = Expression<String>("Language")
    private let authors = Expression<String>("Authors")
    private let subjects = Expression<String>("Subjects")
    private let locc = Expression<String>("LoCC")
    private let bookshelves = Expression<String>("Bookshelves")

    private var db: Connection? = nil

    private init() {
        do {
            let filePath = Bundle.main.path(forResource: "book", ofType: "sqlite3")
            db = try Connection(filePath!)
        } catch {
            print(error)
        }
    }

    func getAuthorsByName(_ a: String) -> [String] {
        var result: [String] = []
        guard let database = db else {
            return []
        }
        do {
            let filter = booksTable.filter(authors.like("\(a)%")).limit(50)
            for row in try database.prepare(filter) {
                result.append(row[authors])
            }
        } catch {
            print(error)
        }
        return result
    }

    func getBooksByAuthor(_ a: String) -> [Book] {
        var books: [Book] = []
        guard let database = db else {
            return []
        }
        do {
            let filter = booksTable.filter(authors.like("\(a)%")).limit(50).filter(title != "No title")
            for row in try database.prepare(filter) {
                books.append(toBook(row: row))
            }
        } catch {
            print(error)
        }
        return books
    }
    
    func getBooksByTitle(_ t: String) -> [Book] {
        var books: [Book] = []
        guard let database = db else {
            return []
        }
        do {
            let filter = booksTable.filter(title.like("\(t)%")).limit(50).filter(title != "No title")
            for row in try database.prepare(filter) {
                books.append(toBook(row: row))
            }
        } catch {
            print(error)
        }
        return books
    }

    func toBook(row: Row) -> Book {
        Book(
            textNum: row[textNum],
            type: row[type],
            issued: row[issued],
            title: row[title],
            language: row[language],
            authors: row[authors],
            subjects: row[subjects],
            locc: row[locc],
            bookshelves: row[bookshelves]
        )
    }

    func getBooksById(_ tNums: Array<String> = []) -> [Book] {
        guard let database = db else {
            return []
        }
        let filter = booksTable.filter(tNums.contains(textNum))
        var books = [Book]()
        do {
            for row in try database.prepare(filter) {
                books.append(toBook(row: row))
            }
        } catch {
            print(error)
            return []
        }
        return books
    }
}
